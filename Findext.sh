#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

url=$1
extensions=("php" "js" "json" "asp" "aspx" "csv" "txt" "pdf" "doc" "docx" "xml" "rar" "zip" "tar" "xls" "xlsx" "html")

mkdir -p files

for ext in "${extensions[@]}"; do
    output_file="files/${ext}.txt"
    
    # Realizar búsqueda y contar resultados
    count=$(gau --subs $url | grep -P "\w+\.$ext(\?|$)" | sort -u | tee "$output_file" | wc -l)
    
    # Eliminar archivo si está vacío
    [ -s "$output_file" ] || rm "$output_file"
    
    echo "Extension: $ext, Found: $count"
done
