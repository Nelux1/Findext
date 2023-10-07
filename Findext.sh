#!/bin/bash

# Función para mostrar el mensaje de ayuda
usage() {
    echo "Usage: $0 [-u <url> | -l <file>]"
    exit 1
}

# Manejo de argumentos usando un bucle while
while getopts ":u:l:" option; do
    case $option in
        u)
            url=$OPTARG
            ;;
        l)
            urls_file=$OPTARG
            ;;
        \?)
            echo "Opción inválida: -$OPTARG"
            usage
            ;;
        :)
            echo "La opción -$OPTARG requiere un argumento."
            usage
            ;;
    esac
done

# Verificar que al menos una de las banderas esté presente
if [[ -z $url && -z $urls_file ]]; then
    echo "Debes especificar una URL (-u) o un archivo de URLs (-l)."
    usage
fi

# Leer URLs desde el archivo si la bandera -l está presente
if [[ ! -z $urls_file ]]; then
    if [[ ! -f $urls_file ]]; then
        echo "El archivo $urls_file no existe."
        exit 1
    fi
    urls=($(cat $urls_file))
else
    urls=($url)
fi

# Crear directorio de salida si no existe
mkdir -p files
# Archivo para todas las URLs
#all_urls_file="files/all_urls.txt"

# Bucle para cada URL
for url in "${urls[@]}"; do
    echo "Buscando en: $url"
    # Limpiar la URL para usarla como parte del nombre del archivo
    clean_url=$(echo "$url" | sed -e 's,https://,,g' -e 's,/$,,g' | awk -F/ '{print $1}')
    for ext in "php" "js" "json" "asp" "aspx" "csv" "txt" "pdf" "doc" "docx" "xml" "rar" "zip" "tar" "xls" "xlsx" "html" "sql" "jar" "jsp" "old" "db" "bak" "backup" "config" ; do
        # Crear nombre de archivo de salida limpio
        output_file="files/${ext}_${clean_url}.txt"
        
        # Realizar búsqueda y contar resultados
        count=$(gau --subs "$url" | grep -P "\w+\.$ext(\?|$)" | sort -u | httpx -silent | tee "$output_file" | wc -l)
        gau --subs "$url" | grep -P "\w+\.$ext(\?|$)" | sort -u | httpx -silent >> files/all_urls_file.txt
        # Eliminar archivo si está vacío
        [ -s "$output_file" ] || rm "$output_file"
        
        if [ "$count" -gt 0 ]; then
            echo "Extension: $ext, Found: $count"

        fi
    done
done
