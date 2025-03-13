#!/bin/bash


usage() {
    echo "Usage: $0 [-u <url> | -l <file>]"
    exit 1
}


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

if [[ -z $url && -z $urls_file ]]; then
    echo "Debes especificar una URL (-u) o un archivo de URLs (-l)."
    usage
fi


if [[ ! -z $urls_file ]]; then
    if [[ ! -f $urls_file ]]; then
        echo "El archivo $urls_file no existe."
        exit 1
    fi
    urls=($(cat $urls_file))
else
    urls=($url)
fi


mkdir -p files


all_urls_file="files/all_urls.txt"


for url in "${urls[@]}"; do
    echo "Buscando en: $url"
    
    clean_url=$(echo "$url" | sed -e 's,https://,,g' -e 's,/$,,g' | awk -F/ '{print $1}')
    for ext in "php" "js" "json" "asp" "aspx" "csv" "txt" "pdf" "doc" "docx" "xml" "rar" "zip" "tar" "xls" "xlsx" "html" "sql" "jar" "jsp" "old" "db" "bak" "backup" "config" ; do
        
        output_file="files/${ext}_${clean_url}.txt"
        
        
        count=$(gau --subs "$url" | grep -P "\w+\.$ext(\?|$)" | sort -u | httpx -silent | tee "$output_file" | wc -l)
        gau --subs "$url" | grep -P "\w+\.$ext(\?|$)" | sort -u | httpx -silent >> files/all_urls_file.txt
        # remove file is empty
        [ -s "$output_file" ] || rm "$output_file"
        
        if [ "$count" -gt 0 ]; then
            echo "Extension: $ext, Found: $count"

        fi
    done
done
