#!/bin/bash

# Valeria Jarquin Vargas, B83986
# Uso: ./ejercicio1.sh <id_proceso>

# Se asigna el primer argumento
id_proceso=$1

# Se verifica si el proceso existe
if ! ps -p $id_proceso > /dev/null; then
    echo " No existe el proceso con ID $id_proceso"
    exit 1
fi

# Si el proceso existe, con ps -o especifico la salida que quiero del proceso
nombre_proceso=$(ps -o comm= -p $id_proceso)
ppid=$(ps -o ppid= -p $id_proceso)
usuario=$(ps -o user= -p $id_proceso)
porcentaje_cpu=$(ps -o %cpu= -p $id_proceso)
consumo_memoria=$(ps -o %mem= -p $id_proceso)
estado=$(ps -o state= -p $id_proceso)
# Con readlink busco la ruta del ejecutable del proceso
path_exe=$(readlink /proc/$id_proceso/exe)

# Imprime la informacion del proceso
echo "Nombre del proceso: $nombre_proceso"
echo "ID del proceso: $id_proceso"
echo "Parent process ID: $ppid"
echo "Usuario propietario: $usuario"
echo "Porcentaje de uso de CPU: $porcentaje_cpu"
echo "Consumo de memoria: $consumo_memoria"
echo "Estado: $estado"
echo "Path del ejecutable: $path_exe"
