#!/bin/bash

# Valeria Jarquin Vargas, B83986
# Uso: ./ejercicio4.sh

# Se crea una variable que guarde el path del directorio a monitorear
directorio=/var/log

# Se crea un bucle para monitorear el directorio constantemente
while true; do
    # Argumento para guardar un evento
    evento=$(inotifywait -q -e create,modify,delete -r "$directorio" --format "%e %w%f")
    if [ $? -eq 0 ]; then
        # Para obtener la fecha y hora del cambio
        fecha_hora=$(date +"%Y-%m-%d %H:%M:%S")
        # Para escribir el evento
        echo "$fecha_hora - Cambio detectado: $evento" >> /home/vjarquin/Plataformas/Laboratorio2/fecha_hora_evento.txt
    fi
done
