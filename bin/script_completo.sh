#!/bin/bash

# Este script correrá todos los análisis
# 09/05/2026
# Carla Silva

echo "INICIANDO ANÁLISIS COMPLETO"

# Ir a carpeta de scripts

cd /home/csilva/proyecto_final/bin || exit

# 1. Unir secuencias

echo "1. Uniendo secuencias"
bash unir_secuencias.sh

# Verificar si terminó correctamente
if [ $? -ne 0 ]; then
    echo "ERROR en unir_secuencias.sh"
    exit 1
fi


# 2. Alineamiento MAFFT

echo "2. Ejecutando MAFFT"
bash alinear_mafft.sh

# Verificar si terminó correctamente
if [ $? -ne 0 ]; then
    echo "ERROR en alinear_mafft.sh"
    exit 1
fi


# 3. RAxML

echo "3. Ejecutando RAxML"
bash correr_raxml.sh

# Verificar si terminó correctamente
if [ $? -ne 0 ]; then
    echo "ERROR en correr_raxml.sh"
    exit 1
fi


# 4. MrBayes

echo "4. Ejecutando MrBayes"
bash correr_mrbayes.sh

# Verificar si terminó correctamente
if [ $? -ne 0 ]; then
    echo "ERROR en correr_mrbayes.sh"
    exit 1
fi


# Final
echo "ANÁLISIS COMPLETO TERMINADO"

# Telegram final
bash telegram.sh "Análisis completo ITS"
