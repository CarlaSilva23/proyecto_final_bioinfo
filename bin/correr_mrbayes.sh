#!/bin/bash

# Este script correrá un análisis Bayesiano en Mr Bayes
# 08/05/2026
# Carla Silva

# Rutas

CONTENEDOR=/home/csilva/proyecto_final/contenedores/bioinfo_container.sif

BASE=/home/csilva/proyecto_final
RESULTADOS=/home/csilva/proyecto_final/resultados

INPUT=ITS_aligned.fasta

FIXED_FASTA=ITS_aligned_fixed.fasta
FIXED_NEX=ITS_aligned_fixed.nex

MAP=tabla_taxa_mrbayes.txt

echo "Corrigiendo nombres duplicados"

rm -f "$RESULTADOS/$MAP"

# Corregir nombres duplicados

awk '
BEGIN{
    OFS=""
}

/^>/ {

    nombre=substr($0,2)

    count[nombre]++

    nuevo=nombre "_" count[nombre]

    print ">", nuevo

    print nuevo "\t" nombre >> "'"$RESULTADOS/$MAP"'"

    next
}

{
    print
}
' "$RESULTADOS/$INPUT" > "$RESULTADOS/$FIXED_FASTA"

echo "Corrigiendo caracteres inválidos"


# SOLO secuencias
sed -i '/^[^>]/ s/_/-/g' "$RESULTADOS/$FIXED_FASTA"

echo "Convirtiendo FASTA a NEXUS"

apptainer exec \
    -B "$BASE":/work \
    "$CONTENEDOR" \
    python3 - <<EOF
from Bio import AlignIO

alignment = AlignIO.read(
    "/work/resultados/$FIXED_FASTA",
    "fasta"
)

# Definir el tipo de molécula
for record in alignment:
    record.annotations["molecule_type"] = "DNA"

AlignIO.write(
    alignment,
    "/work/resultados/$FIXED_NEX",
    "nexus"
)
EOF

echo "Agregando bloque de MrBayes"


cat >> "$RESULTADOS/$FIXED_NEX" <<EOF

begin mrbayes;

    set autoclose=yes nowarn=yes;

    lset nst=6 rates=gamma;

    mcmcp ngen=1000000 \
          samplefreq=100 \
          printfreq=1000 \
          diagnfreq=1000 \
          nchains=4 \
          temp=0.2;

    mcmc;

    sump;
    sumt;

end;

EOF


echo "Iniciando MrBayes"


apptainer exec \
    -B "$BASE":/work \
    --pwd /work/resultados \
    "$CONTENEDOR" \
    env BEAGLE_DISABLE=1 mb "$FIXED_NEX"


echo "MrBayes terminado"

echo "Archivos generados en:"
echo "$RESULTADOS"

# Telegram
bash telegram.sh "Análisis bayesiano ITS"
