 #!/bin/bash

# Valeria Jarquin Vargas, B83986
# Uso: ./ejercicio3.sh <ejecutable>

# Argumento para guardar el ejecutable
ejecutable="$1"

# Se guarda en una variable la direccion del ejecutable
dir_path=$(which $ejecutable)

# Nombre del archivo de registro
log_file="uso_cpu_mem.log"

# Iniciar ejecución del binario en segundo plano
$dir_path &

# Para obtener el ID del proceso del ejecutable
pid=$!

# Función para obtener el uso de CPU y memoria y escribirlo en el archivo de registro
monitor_proceso() {
    while ps -p $pid > /dev/null; do
        tiempo=$(date +%s)
        uso_cpu=$(ps -p $pid -o %cpu | grep -v CPU)
        uso_mem=$(ps -p $pid -o %mem | grep -v MEM)
        echo "$tiempo $uso_cpu $uso_mem" >> $log_file
        sleep 1
    done
}

# Para monitorear el proceso en segundo plano
monitor_proceso &

# Esperar a que el proceso termine
wait $pid

gnuplot <<- EOF
    set xlabel "Tiempo"
    set ylabel "Uso (%)"
    set title "Uso de CPU y Memoria en función del Tiempo"
    set grid
    set term png
    set output "uso_cpu_mem.png"
    plot "$log_file" using 1:2 with lines title "CPU", \
         "$log_file" using 1:3 with lines title "Memoria"
EOF

echo "Grafico generado: uso_cpu_mem.png"
