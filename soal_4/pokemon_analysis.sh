=#!/bin/bash

# Mengecek apakah file CSV sudah ada, jika tidak, unduh terlebih dahulu
if [ ! -f "pokemon_usage.csv" ]; then
    echo "Mengunduh dataset pokemon_usage.csv..."
    wget -q "https://drive.usercontent.google.com/u/0/uc?id=1n-2n_ZOTMleqa8qZ2nB8ALAbGFyN4-LJ&export=download" -O pokemon_usage.csv
fi

# Cek apakah file berhasil diunduh
if [ ! -f "pokemon_usage.csv" ]; then
    echo "Error: Gagal mendownload pokemon_usage.csv! Periksa koneksi internet."
    exit 1
fi

# Menentukan perintah dari argumen
if [ "$#" -lt 2 ]; then
    echo "Error: no arguments provided"
    echo "Use -h or --help for more information"
    exit 1
fi

FILENAME=$1
COMMAND=$2

# Switch case berdasarkan command yang diberikan
case "$COMMAND" in
    --info)
        echo "Summary of $FILENAME"
        HIGHEST_USAGE=$(awk -F',' 'NR > 1 {if ($2 > max) {max=$2; name=$1}} END {print name " with " max "%"}' "$FILENAME")
        HIGHEST_RAW=$(awk -F',' 'NR > 1 {if ($3 > max) {max=$3; name=$1}} END {print name " with " max " uses"}' "$FILENAME")
        echo "Highest Adjusted Usage:  $HIGHEST_USAGE"
        echo "Highest Raw Usage:       $HIGHEST_RAW"
        ;;
    
    --sort)
        if [ -z "$3" ]; then
            echo "Error: no sort column provided"
            echo "Usage: ./pokemon_analysis.sh pokemon_usage.csv --sort <column>"
            exit 1
        fi
        COLUMN=$3
        echo "Sorting Pokémon by $COLUMN..."

        # Cari indeks kolom yang sesuai
        COL_NUM=$(awk -F',' -v col="$COLUMN" 'NR==1 {
            for (i=1; i<=NF; i++) {
                if ($i == col) print i
            }
        }' "$FILENAME")

        if [ -z "$COL_NUM" ]; then
            echo "Error: Column '$COLUMN' not found in dataset"
            exit 1
        fi

        # Cetak header satu kali, lalu sorting tanpa mencetak header dua kali
        awk 'NR==1' "$FILENAME"
        awk -F',' 'NR>1' "$FILENAME" | sort -t, -k"$COL_NUM","$COL_NUM"nr
        ;;
    
    --grep)
        if [ -z "$3" ]; then
            echo "Error: no Pokémon name provided"
            echo "Usage: ./pokemon_analysis.sh pokemon_usage.csv --grep <name>"
            exit 1
        fi
        POKEMON_NAME=$3
        echo "Searching for Pokémon '$POKEMON_NAME'..."
        awk -F',' -v name="$POKEMON_NAME" 'NR==1 || tolower($1) ~ tolower(name)' "$FILENAME"
        ;;
    
    --filter)
        if [ -z "$3" ]; then
            echo "Error: no filter option provided"
            echo "Usage: ./pokemon_analysis.sh pokemon_usage.csv --filter <type>"
            exit 1
        fi
        POKEMON_TYPE=$3
        echo "Filtering Pokémon with Type '$POKEMON_TYPE'..."

        awk -F',' -v type="$POKEMON_TYPE" '
        BEGIN { IGNORECASE = 1 }  # Bikin pencarian tidak case-sensitive
        NR == 1 || $4 ~ ("^ *" type " *$") || $5 ~ ("^ *" type " *$") { 
            print $0 
        }' "$FILENAME"
        ;;
    
    -h|--help)
        echo "============================"
        echo "        HELP SCREEN         "
        echo "============================"
        echo ""
        echo "        (¯\`·._.·Pokémon·._.·´¯)"
        echo "         _______  "
        echo "       /       \\  "
        echo "      |  ●   ●  | "
        echo "      |    ◇    | "
        echo "       \\___^___/  "
        echo ""
        echo "Usage:"
        echo "  ./pokemon_analysis.sh pokemon_usage.csv --info               # Menampilkan ringkasan data Pokémon"
        echo "  ./pokemon_analysis.sh pokemon_usage.csv --sort <column>      # Mengurutkan Pokémon berdasarkan kolom tertentu"
        echo "  ./pokemon_analysis.sh pokemon_usage.csv --grep <name>        # Mencari Pokémon berdasarkan nama"
        echo "  ./pokemon_analysis.sh pokemon_usage.csv --filter <type>      # Menampilkan Pokémon berdasarkan tipe"
        echo "  ./pokemon_analysis.sh -h / --help                            # Menampilkan help screen"
        echo "============================"
        ;;
    
    *)
        echo "Error: Unknown command '$COMMAND'"
        echo "Use -h or --help for more information"
        exit 1
        ;;
esac


