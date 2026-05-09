#!/bin/bash

# Este script correrá un análisis de Máxima Verosimilitud en RAxML
# 07/05/2026
# Carla Silva

# Rutas

CONTENEDOR=/home/csilva/proyecto_final/contenedores/bioinfo_container.sif
BASE=/home/csilva/proyecto_final/resultados

INPUT=ITS_aligned.fasta
FIXED=ITS_aligned_fixed.fasta
MAP=tabla_taxa.txt

PREFIX=ITS

echo "Corrigiendo nombres duplicados"

# Eliminar archivos previos
rm -f "$BASE/$MAP"
rm -f "$BASE/$FIXED"


# Corregir nombres repetidos

awk '
BEGIN{
    OFS=""
}

/^>/ {

    nombre=substr($0,2)

    count[nombre]++

    nuevo=nombre "_" count[nombre]

    print ">", nuevo

    print nuevo "\t" nombre >> "'"$BASE/$MAP"'"

    next
}

{
    print
}
' "$BASE/$INPUT" > "$BASE/$FIXED"

echo "Reemplazando caracteres inválidos"


# Reemplazar "_" por "-" SOLO en secuencias
sed -i '/^[^>]/ s/_/-/g' "$BASE/$FIXED"

echo "Archivo corregido:"
echo "$BASE/$FIXED"

echo "Tabla de equivalencias:"
echo "$BASE/$MAP"


echo "Iniciando análisis con RAxML"



# Ejecutar RAxML

apptainer exec \
    -B /home/csilva/proyecto_final:/work \
    --pwd /work/resultados \
    "$CONTENEDOR" \
    raxmlHPC-PTHREADS-SSE3 \
    -T 4 \
    -s "$FIXED" \
    -n "$PREFIX" \
    -m GTRGAMMA \
    -p 12345

echo "RAxML terminado"


echo "Archivos generados en:"
echo "$BASE/RAxML_*"

# Mensaje a Telegram
bash telegram.sh "Análisis de ML ITS"
