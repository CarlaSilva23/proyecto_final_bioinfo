#!/bin/bash

# Este script ejecutará MAFFT para alinear las secuencias de un fasta
# 05/05/2026
# Carla Silva


# Rutas
CONTENEDOR=/home/csilva/proyecto_final/contenedores/bioinfo_container.sif
BASE=/home/csilva/proyecto_final

INPUT=final_secuencias_ITS.fasta

OUT_FASTA=ITS_aligned.fasta
OUT_PHY=ITS_aligned.phy

echo "Iniciando alineamiento con MAFFT"

# FASTA REAL
apptainer exec --fakeroot \
    -B "$BASE":/work \
    "$CONTENEDOR" \
    bash -c "
mafft --auto --anysymbol \
/work/data/mis_secuencias/$INPUT \
> /work/resultados/$OUT_FASTA
"

# PHYLIP
apptainer exec --fakeroot \
    -B "$BASE":/work \
    "$CONTENEDOR" \
    bash -c "
mafft --auto --anysymbol --phylipout \
/work/data/mis_secuencias/$INPUT \
> /work/resultados/$OUT_PHY
"

echo "Alineamiento terminado"

echo "Archivos generados:"
echo "/home/csilva/proyecto_final/resultados/$OUT_FASTA"
echo "/home/csilva/proyecto_final/resultados/$OUT_PHY"

# Telegram
bash telegram.sh "alineamiento_mafft"

