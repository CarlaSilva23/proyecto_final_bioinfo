#!/bin/bash

# Este script convierte FASTA a PHYLIP y NEXUS usando seqret dentro del contenedor
# 06/05/2026
# Escrito por Carla Silva

# Rutas
CONTENEDOR=/home/csilva/proyecto_final/contenedores/bioinfo_container.sif
BASE=/home/csilva/proyecto_final

INPUT=ITS_aligned.fasta
OUT_PHY=ITS_aligned.phy
OUT_NEX=ITS_aligned.nex

echo "Convirtiendo alineamiento con seqret"

# FASTA a PHYLIP
apptainer exec \
    -B "$BASE":/work \
    "$CONTENEDOR" \
    seqret \
    -sequence /work/resultados/$INPUT \
    -outseq /work/resultados/$OUT_PHY \
    -osformat2 phylip

# FASTA a NEXUS
apptainer exec \
    -B "$BASE":/work \
    "$CONTENEDOR" \
    seqret \
    -sequence /work/resultados/$INPUT \
    -outseq /work/resultados/$OUT_NEX \
    -osformat2 nexus

echo "Conversión terminada"

echo "Archivos generados:"
echo "$BASE/resultados/$OUT_PHY"
echo "$BASE/resultados/$OUT_NEX"

# Notificación Telegram
bash telegram.sh "conversion de formatos"
