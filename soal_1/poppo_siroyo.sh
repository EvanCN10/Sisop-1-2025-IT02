#!/bin/bash

# Mengunduh file
wget "https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download" -O data.txt

# Deklarasi opsi
option1="a"
option2="b"
option3="c"
option4="d"

# Meminta input dari user
echo "Pilih a/b/c/d:"
read answer

# Cek jawaban
if [ "$answer" == "$option1" ]; then
    awk '/Chris Hemsworth/ { ++n } 
    END { print "Chris Hemsworth membaca", n, "kali." }' data.txt

elif [ "$answer" == "$option2" ]; then
    awk -F',' '
    BEGIN { total = 0; count = 0 }
    $8 == "Tablet" { total += $6; count++ }
    END { 
        if (count > 0) 
            print "Rata-rata durasi membaca dengan Tablet adalah", total / count, "menit."; 
        else 
            print "Tidak ada data membaca dengan Tablet.";
    }' data.txt

elif [ "$answer" == "$option3" ]; then
    awk -F',' '
    NR == 1 { next }  # Lewati baris header jika ada
    $7 > max_rating { 
        max_rating = $7; 
        name = $2; 
        book = $3; 
    }
    END { 
        if (max_rating > 0) 
            print "Pembaca dengan rating tertinggi:", name, "-", book, "-", max_rating; 
        else 
            print "Tidak ada Data";
    }' data.txt

elif [ "$answer" == "$option4" ]; then
    awk -F',' '
    NR == 1 { next }  
    $5 >= "2023" && $9 == "Asia" { genre_count[$4]++ }  
    END { 
        max_genre = ""; max_count = 0;
        for (a in genre_count) { 
            if (genre_count[a] > max_count) {
                max_count = genre_count[a];
                max_genre = a;
            }
        }
        if (max_count > 0) {
            print "Genre paling populer di Asia setelah 2023 adalah", max_genre, "dengan", max_count, "buku.";
        } else {
            print "Tidak ada data genre.";
        }
    }' data.txt
else
    echo "Pilihan tidak valid."
fi
