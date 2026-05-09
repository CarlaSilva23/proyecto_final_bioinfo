#!/bin/bash

# Este script juntará las secuencias de los colaboradores en un solo archivo fasta
# 05/05/2026
# Carla Silva

# Rutas
BASE_DIR=~/proyecto_final/data
OUT_DIR="$BASE_DIR/mis_secuencias"
OUT_FILE="$OUT_DIR/final_secuencias_ITS.fasta"

# Crear archivo de salida
> "$OUT_FILE"

echo "Uniendo secuencias"

# Recorrer carpetas y concatenar archivos fasta
for dir in mis_secuencias secuencias_douglas secuencias_rachel
do
    for file in "$BASE_DIR/$dir"/*.fasta "$BASE_DIR/$dir"/*.fa "$BASE_DIR/$dir"/*.fas
    do
        if [ -f "$file" ]; then
            echo "Agregando $file"
            cat "$file" >> "$OUT_FILE"
        fi
    done
done

echo "Archivo final creado en:"
echo "$OUT_FILE"

# Mensaje a Telegram
bash telegram.sh "unir secuencias"

