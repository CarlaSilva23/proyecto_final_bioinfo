#!/bin/bash

# Este script enviará mensajes a Telegram
# 05/05/2026
# Carla Silva

# Variable
NOMBRE_ANALISIS="$1"

# Credenciales
source .env

# Fecha
FECHA=$(date +"%d-%m-%Y %H:%M:%S")

# Mensaje
MENSAJE="El análisis '$NOMBRE_ANALISIS' terminó correctamente a las $FECHA"

# Enviar mensaje a Telegram
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="$MENSAJE"
