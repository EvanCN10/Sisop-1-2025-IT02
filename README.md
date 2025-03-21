# Soal 1
<pre><code>
#!/bin/bash

# Mengunduh file
wget "https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download" -O data.txt
</code></pre>

#!/bin/bash Menunjukkan bahwa skrip ini akan dijalankan menggunakan Bash.
wget: Perintah untuk mengunduh file dari internet.
-O data.txt: Menginstruksikan wget untuk menyimpan hasil unduhan dengan nama data.txt.

<pre><code>
# Deklarasi opsi
option1="a"
option2="b"
option3="c"
option4="d"

# Meminta input dari user
echo "Pilih a/b/c/d:"
read answer
</code></pre>
Mendeklarasi opsi dan meminta output dari user.

<pre><code>
# Cek jawaban
if [ "$answer" == "$option1" ]; then
    awk '/Chris Hemsworth/ { ++n } 
    END { print "Chris Hemsworth membaca", n, "kali." }' data.txt
</code></pre>
Kode berikut menggunakan perintah awk untuk menghitung berapa kali nama "Chris Hemsworth" muncul dalam sebuah file teks bernama data.txt. Perintah ini mencari setiap baris dalam file yang mengandung teks tersebut, lalu menambahkan nilai variabel n setiap kali ditemukan. Setelah semua baris diproses, perintah dalam blok END akan mencetak jumlah total kemunculan nama dalam format: "Chris Hemsworth membaca X kali.", di mana X adalah jumlah kemunculan yang ditemukan.
<pre><code>
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
</code></pre>
Perintah awk ini digunakan untuk menghitung rata-rata waktu membaca bagi pengguna yang menggunakan Tablet dari file data.txt, yang datanya dipisahkan dengan koma (,). Awalnya, variabel total dan count diset ke nol untuk menyimpan jumlah total durasi membaca dan jumlah pengguna yang memakai Tablet. Saat memproses setiap baris, jika kolom ke-8 berisi kata "Tablet", maka durasi membaca di kolom ke-6 akan ditambahkan ke total, dan count bertambah satu. Setelah semua data diproses, jika ada pengguna yang membaca dengan Tablet, perintah akan mencetak rata-rata waktu membaca. Namun, jika tidak ada data yang sesuai, akan muncul pesan bahwa tidak ada pengguna yang membaca dengan Tablet.
<pre><code>
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
</code></pre>

Skrip di atas adalah bagian dari perintah shell yang menggunakan AWK untuk mencari pembaca dengan rating tertinggi dari file data.txt, yang diasumsikan berbentuk CSV dengan pemisah koma. Pertama, perintah awk -F',' digunakan untuk menetapkan koma sebagai pemisah kolom. Kemudian, baris pertama (header) dilewati dengan NR == 1 { next }. Selanjutnya, setiap baris dicek pada kolom ke-7 yang berisi rating. Jika rating tersebut lebih tinggi dari max_rating, maka nilai rating, nama pembaca (kolom ke-2), dan judul buku (kolom ke-3) diperbarui. Setelah semua data diproses, bagian END mencetak pembaca dengan rating tertinggi beserta bukunya. Jika tidak ada data valid, pesan "Tidak ada Data" akan ditampilkan.

<pre><code>
elif [ "$answer" == "$option4" ]; then
    awk -F',' '
NR == 1 { next }  

{
    split($5, date, "-");  
    year = date[1] + 0;
    month = date[2] + 0;
    day = date[3] + 0;

    if (year > 2023 && $9 == "Asia") {
        genre_count[$4]++;
    }
}

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
</code></pre>
Kode AWK ini membaca file CSV dengan pemisah koma (-F',') dan melewati baris pertama yang merupakan header. Setiap baris diproses dengan memisahkan kolom tanggal ($5) untuk mengambil tahun, lalu diperiksa apakah lebih besar dari 2023 dan wilayahnya Asia ($9 == "Asia"). Jika memenuhi syarat, jumlah buku untuk setiap genre ($4) dihitung dalam array genre_count. Setelah semua data diproses, bagian END mencari genre dengan jumlah terbanyak dan mencetaknya dalam format "Genre paling populer di Asia setelah 2023 adalah [genre] dengan [jumlah] buku." 

# Soal 2
1. register.sh (Registrasi Player)
   
<pre><code>
#!/bin/bash
</code></pre>
(#!/bin/bash) Menunjukkan bahwa skrip ini akan dijalankan menggunakan Bash.

<pre><code>
database="/home/binar/soal2/data/player.csv"
</code></pre>
Menentukan lokasi file database tempat semua "Player" akan disimpan.

<pre><code>
echo "masukkan email: "
read email
if grep -q "^$email," "$database"; then
    echo "email sudah terdaftar"
    exit 1
elif [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "email valid"
else
    echo "email invalid"
fi
</code></pre>
meminta user untuk memberikan input email dengan format memiliki "@" dan ".".

<pre><code>
if grep -q "^$email," "$database"; then
    echo "email sudah terdaftar"
    exit 1
fi
</code></pre>
mengecek apakah input email sudah terdaftar di dalam database.

<code><pre>
echo " "
echo "masukkan username: "
read username
</code></pre>
meminta user untuk memberikan input user.

<code><pre>
echo " "
echo "masukkan password (gunakan min. 8 char, kapital, angka): "
read -s password
if [[ $password =~ [A-Z] && $password =~ [a-z] && $password =~ [0-9] && ${#password} -ge 8 ]]; then
    echo "password valid"
else
    echo "password invalid"
    exit 1
fi
</code></pre>
meminta user untuk memberikan input password dengan format minimal 8 karakter, huruf kapital, dan angka.
"-s" digunakan agar input tidak terlihat.

<code><pre>
salt="1234"
hashed_password=$(echo -n "$salt$password" | sha256sum | awk '{print $1}')
password=$hashed_password
</code></pre>
hash password dengan algoritma hashing sha256sum yang memakai static salt.

<code><pre>
echo " " 
echo "$email,$username,$password" >> $database
echo "selamat datang $username"
</code></pre>
memasukkan input email, username, dan password ke dalam database serta memberikan sambutan kepada player/user.

2. login.sh (login player)

<pre><code>
#!/bin/bash
</code></pre>
(#!/bin/bash) Menunjukkan bahwa skrip ini akan dijalankan menggunakan Bash.

<code><pre>
database="/home/binar/soal2/data/player.csv"
</code></pre>
Menentukan lokasi file database tempat semua "Player" akan disimpan.

<code><pre>
echo "masukkan email: "
read email
if ! grep -q "^$email," /home/binar/soal2/data/player.csv; then
    echo "email tidak terdaftar"
    exit 1
fi
</code></pre>
meminta user untuk memberikan input email kemudian mengecek apakah email yang dimasukkan ada dalam database.

<code><pre>
echo " "
echo "masukkan password: "
read -s password
</code></pre>
meminta user untuk memasukkan input password. "-s" digunakan agar input tidak terlihat.

<code><pre>
salt="1234"
hashed_password=$(echo -n "$salt$password" | sha256sum | awk '{print $1}')
</code></pre>
hash password dengan algoritma hashing sha256sum yang memakai static salt.

<code><pre>
if grep -q "^$email,.*,${hashed_password}$" "$database"; then
    username=$(grep "^$email," "$database" | awk -F',' '{print $2}')
    echo "Login sukses!"
    echo "selamat datang $username"
else
    echo "Invalid email atau password!"
    exit 1
fi
</code></pre>
mengecek apakah input yang diberikan sama dengan yang ada pada database.

3. terminal.sh

<code><pre>
echo "Menu: "
echo "1. register"
echo "2. login"
echo "3. exit"
</code></pre>
untuk menampilkan menu.

<code><pre>
read -p "pilih menu: " pilih

if [ "$pilih" = "1" ]; then
	./register.sh
elif [ "$pilih" = "2" ]; then
	./login.sh
elif [ "$pilih" = "3" ]; then
	exit 0
else 
	echo "menu invalid"
fi
</code></pre>
meminta user untuk menginput pilihan menu.

<code><pre>
if [ "$pilih" = "1" ]; then
	./register.sh
</code></pre>
apabila user memasukkan input "1" maka register.sh akan dijalankan.

<code><pre>
elif [ "$pilih" = "2" ]; then
	./login.sh
</code></pre>
apabila user memasukkan input "2" maka login.sh akan dijalankan.

<code><pre>
elif [ "$pilih" = "3" ]; then
	exit 0
</code></pre>
apabila user memasukkan input "3" maka program akan selesai.

<code><pre>
else 
	echo "menu invalid"
</code></pre>
apabila user memasukkan input "4" maka program akan memberitahu user bahwa apa yang diinput invalid.
    
# Soal 3
<pre><code>
#!/bin/bash
clear
</code></pre>

(#!/bin/bash) menentukan bahwa skrip dijalankan dengan Bash, sedangkan clear membersihkan layar terminal sebelum eksekusi.

<pre><code>
speak_to_me() {
    while true; do
        curl -s https://www.affirmations.dev | jq -r '.affirmation'
        sleep 1
    done
}
</code></pre>
a. Fungsi speak_to_me adalah script Bash yang menampilkan afirmasi positif secara terus-menerus. Dengan menggunakan curl, script mengambil data dari API https://www.affirmations.dev, lalu jq mengekstrak teks afirmasi yang diterima. Loop while true memastikan proses ini berulang setiap detik dengan sleep 1, hingga dihentikan secara manual.

<pre><code>
on_the_run() {
    panjang_total=50
    progress=0
    while [ $progress -le $panjang_total ]; do
        printf "\r[%-${panjang_total}s] %d%%" "$(awk -v p=$progress 'BEGIN {for (i=0; i<p; i++) printf "="}')" $((progress * 100 / panjang_total))
        progress=$((progress + 1))
        sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
    done
    echo -e "\nDone!"
}
</code></pre>
b. Fungsi on_the_run dalam Bash merupakan skrip yang menampilkan animasi progress bar di terminal dengan jeda waktu acak. Saat fungsi dijalankan, ia pertama-tama mencetak "Playing: On the Run" sebagai indikasi proses yang sedang berlangsung. Kemudian, fungsi mendeklarasikan dua variabel lokal: total=50, yang menentukan panjang maksimal progress bar, dan progress=0, sebagai nilai awal progres. Dalam perulangan while, skrip mencetak progress bar menggunakan printf, di mana jumlah karakter "=" bertambah seiring nilai progress meningkat, serta menampilkan persentase kemajuan yang dihitung dari (progress * 100 / total). Fungsi sleep digunakan dengan nilai acak antara 0.1 hingga 1 detik menggunakan perintah awk, yang membuat setiap iterasi memiliki jeda yang bervariasi. Proses ini terus berjalan hingga progress mencapai total, dan setelah selesai, skrip menampilkan "Done!". 


<pre><code>
time_display() {
    while true; do
        clear
        echo "===Time display==="
        date "+%Y-%m-%d %H:%M:%S"
        sleep 1
    done
}
</code></pre>
c. Fungsi time_display dalam Bash menampilkan waktu saat ini secara real-time dengan efek refresh setiap detik. Ketika fungsi dijalankan, ia pertama-tama mencetak "Playing: Time", lalu masuk ke dalam loop tak terbatas (while true). Dalam setiap iterasi, perintah clear digunakan untuk membersihkan layar terminal, kemudian date "+%Y-%m-%d %H:%M:%S" mencetak tanggal dan waktu dalam format YYYY-MM-DD HH:MM:SS. Fungsi ini berhenti sejenak selama 1 detik menggunakan sleep 1, lalu mengulang prosesnya, menciptakan efek jam digital yang terus diperbarui hingga pengguna menghentikannya secara manual.

<pre><code>
money_matrix() {
    symbols="!@#$%"
    cols=$(tput cols)
    lines=$(tput lines)

    while true; do
        clear
        for ((i = 0; i < cols; i += 3)); do
            symbol=${symbols:$((RANDOM % ${#symbols})):1}
            echo -ne "\033[$((RANDOM % lines));${i}H$symbol"
        done
        sleep 0.1
    done
}
</code></pre>
d. Fungsi money_matrix dalam Bash menciptakan efek "hujan simbol" di terminal menggunakan karakter !@#$%, yang terus diperbarui dalam loop tanpa henti hingga dihentikan secara manual. Saat dijalankan, skrip terlebih dahulu mendapatkan ukuran terminal menggunakan tput cols dan tput lines, lalu dalam setiap iterasi, layar dibersihkan dengan clear. Perulangan for digunakan untuk mencetak simbol acak di terminal, di mana simbol dipilih dari string symbols menggunakan ekspresi ${symbols:$((RANDOM % ${#symbols})):1}, yang mengambil satu karakter secara acak. Simbol ini kemudian dicetak di posisi acak dalam terminal menggunakan echo -ne "\033[$((RANDOM % lines));${i}H$symbol", dengan kode  "\033[<baris>;<kolom>H". Simbol hanya muncul pada beberapa kolom tertentu (i += 3). Dengan sleep 0.1, tampilan diperbarui setiap 0.1 detik per frame, menciptakan efek animasi hujan simbol yang bergerak dinamis di layar terminal.

<pre><code>
brain_damage() {
    while true; do
        clear
        ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | awk '{printf "%-7s %-10s %-6s %-6s %s\n", $1, $2, $3, $4, $5}' | head -n 20
        sleep 1
    done
}
</code></pre>
e. Fungsi brain_damage dalam Bash menampilkan 20 proses dengan penggunaan CPU tertinggi secara real-time di terminal. Fungsi ini berjalan dalam loop tanpa henti hingga dihentikan secara manual. Setiap detik, terminal dibersihkan dengan clear, lalu perintah ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu dijalankan untuk mengambil daftar proses, diurutkan berdasarkan penggunaan CPU tertinggi. Hasilnya diformat menggunakan awk agar tampil lebih rapi dengan kolom PID, User, CPU, Memori, dan Nama Proses, lalu head -n 20 memastikan hanya 20 proses teratas yang ditampilkan. Dengan sleep 1, daftar ini diperbarui setiap detik, sehingga bisa digunakan untuk memantau penggunaan CPU secara langsung.
<pre><code>
case "$1" in
    --play=Speak\ to\ Me) speak_to_me ;;
    --play=On\ the\ Run) on_the_run ;;
    --play=Time) time_display ;;
    --play=Money) money_matrix ;;
    --play=Brain\ Damage) brain_damage ;;
    *)
        echo "Usage: $0 --play=\"<Track>\""
        echo "Available tracks: Speak to Me, On the Run, Time, Money, Brain Damage"
        exit 1
        ;;
esac
</code></pre>
- Jika argumen sesuai dengan salah satu opsi (--play=Speak to Me, --play=On the Run, dll.), maka fungsi terkait (speak_to_me, on_the_run, dll.) akan dijalankan.
- Jika argumen tidak cocok dengan opsi yang tersedia (* sebagai default), skrip akan menampilkan pesan penggunaan dan daftar opsi yang tersedia, lalu keluar dengan kode error (exit 1).

# Soal 4
<pre><code>
    if [ ! -f "pokemon_usage.csv" ]; then
    echo "Mengunduh dataset pokemon_usage.csv..."
    wget -q "https://drive.usercontent.google.com/u/0/uc?id=1n-2n_ZOTMleqa8qZ2nB8ALAbGFyN4-LJ&export=download" -O pokemon_usage.csv
fi
</pre></code>
Code ini digunkan untuk memastikan apakah file CSV sudah ada, dan apabila tidak ada maka Code ini akan mengunduh terlebih dahulu.
- Mengecek apakah file pokemon_usage.csv sudah ada di direktori saat ini.
- Jika tidak ada (! -f), maka akan mengunduh file tersebut menggunakan wget.
- Opsi -q digunakan agar proses unduhan tidak menampilkan output di terminal.
- File yang diunduh disimpan dengan nama pokemon_usage.csv.


<pre><code>
    if [ ! -f "pokemon_usage.csv" ]; then
    echo "Error: Gagal mendownload pokemon_usage.csv! Periksa koneksi internet."
    exit 1
fi
</pre></code>
Code ini digunakan untuk memastikan bahwa file <pre>pokemon_usage.csv</pre> berhasil diunduh atau tidak.
- Jika file pokemon_usage.csv masih belum ada setelah proses unduhan, maka ditampilkan pesan error.
- Script dihentikan dengan exit 1 untuk mencegah eksekusi lebih lanjut.


<pre><code>
    if [ "$#" -lt 2 ]; then
    echo "Error: no arguments provided"
    echo "Use -h or --help for more information"
    exit 1
fi
</code></pre>
Code ini digunakan untuk mengecek jumlah argumen yang diberikan.
- Mengecek apakah jumlah argumen ($#) yang diberikan kurang dari 2.
- Jika ya, maka menampilkan pesan error dan menyarankan penggunaan opsi -h atau --help.
- Script dihentikan dengan exit 1.


<pre><code>
    FILENAME=$1
    COMMAND=$2
</pre></code>
Kode ini untuk menyimpan argumen pertama dan kedua ke variabel.
- FILENAME menyimpan argumen pertama (nama file CSV).
- COMMAND menyimpan argumen kedua (perintah yang diberikan).


<pre><code>
    case "$COMMAND" in
    --info)
        echo "Summary of $FILENAME"
        HIGHEST_USAGE=$(awk -F',' 'NR > 1 {if ($2 > max) {max=$2; name=$1}} END {print name " with " max "%"}' "$FILENAME")
        HIGHEST_RAW=$(awk -F',' 'NR > 1 {if ($3 > max) {max=$3; name=$1}} END {print name " with " max " uses"}' "$FILENAME")
        echo "Highest Adjusted Usage:  $HIGHEST_USAGE"
        echo "Highest Raw Usage:       $HIGHEST_RAW"
        ;;
</pre></code>
Merupakan kode untuk menjawab soal 4A yang dimana ingin menampilkan ringkasan data Pokemon dengan command yang diakhiri (--info).
- awk digunakan untuk mencari Pokémon dengan penggunaan tertinggi:
    - Adjusted Usage (persentase tertinggi di kolom kedua).
    - Raw Usage (jumlah penggunaan tertinggi di kolom ketiga).
- Hasilnya ditampilkan di terminal.


<pre><code>
   --sort)
    if [ -z "$3" ]; then
        echo "Error: no sort column provided"
        echo "Usage: ./pokemon_analysis.sh pokemon_usage.csv --sort <column>"
        exit 1
    fi
    COLUMN=$3
    echo "Sorting Pokémon by $COLUMN..."

    COL_NUM=$(awk -F',' -v col="$COLUMN" 'NR==1 {
        for (i=1; i<=NF; i++) {
            if ($i == col) print i
        }
    }' "$FILENAME")

    if [ -z "$COL_NUM" ]; then
        echo "Error: Column '$COLUMN' not found in dataset"
        exit 1
    fi

    awk 'NR==1' "$FILENAME"
    awk -F',' 'NR>1' "$FILENAME" | sort -t, -k"$COL_NUM","$COL_NUM"nr
    ;;
</pre></code>
Code ini digunakan untuk mengurutkan data Pokémon berdasarkan kolom tertentu.
- Mengecek apakah pengguna sudah memberikan nama kolom untuk sorting.
Jika tidak ada, maka program akan menampilkan error dan memberikan petunjuk penggunaan.
- Mencari indeks kolom berdasarkan nama yang diberikan.
Menggunakan awk, program akan membaca baris pertama (header) untuk menemukan indeks kolom yang sesuai dengan nama yang diberikan oleh pengguna.
- Memastikan apakah kolom yang diminta tersedia di dataset.
Jika tidak ditemukan, program akan memberikan pesan error.
- Mencetak header satu kali dan mengurutkan data.
    awk 'NR==1' → Mencetak header terlebih dahulu.
    awk -F',' 'NR>1' → Mengambil semua baris kecuali header.
    sort -t, -k"$COL_NUM","$COL_NUM"nr → Mengurutkan secara numerik dari besar ke kecil (nr = numeric reverse).

<pre><code>
        --grep)
        if [ -z "$3" ]; then
            echo "Error: no Pokémon name provided"
            echo "Usage: ./pokemon_analysis.sh pokemon_usage.csv --grep <name>"
            exit 1
        fi
        POKEMON_NAME=$3
        echo "Searching for Pokémon '$POKEMON_NAME'..."
        head -n 1 "$FILENAME"
        grep -i "^$POKEMON_NAME" "$FILENAME" | sort -t, -k2,2nr
        ;;
</pre></code>
Merupakan kode untuk menjawab soal 4C yang dimana ingin mencari pokemon berdasarkan nama dengan menggunakan command yang diakhiri (--grep).
- Memeriksa apakah nama Pokémon ($3) diberikan, jika tidak, menampilkan error.
- grep -i "^$POKEMON_NAME" digunakan untuk mencari Pokémon berdasarkan nama tanpa memperhatikan huruf besar/kecil (-i).
- Hasil pencarian diurutkan berdasarkan penggunaan tertinggi.


<pre><code>
        --filter)
    if [ -z "$3" ]; then
        echo "Error: no filter option provided"
        echo "Usage: ./pokemon_analysis.sh pokemon_usage.csv --filter <type>"
        exit 1
    fi
    POKEMON_TYPE=$3
    echo "Filtering Pokémon with Type '$POKEMON_TYPE'..."

    awk -F',' -v type="$POKEMON_TYPE" '
    BEGIN { IGNORECASE = 1 }
    NR == 1 || $4 ~ ("^ *" type " *$") || $5 ~ ("^ *" type " *$") { 
        print $0 
    }' "$FILENAME"
    ;;
</pre></code>
Code ini digunakan untuk menampilkan Pokémon yang memiliki tipe tertentu (Type1 atau Type2).
- Mengecek apakah pengguna sudah memberikan tipe Pokémon untuk filtering.
Jika tidak, maka program akan menampilkan error dan memberikan petunjuk penggunaan.
- Menggunakan awk untuk memfilter data berdasarkan tipe Pokémon.
    - BEGIN { IGNORECASE = 1 } → Pencarian akan tidak case-sensitive, sehingga fire = Fire.
    - NR == 1 → Selalu mencetak header.
    - $4 ~ ("^ *" type " *$") || $5 ~ ("^ *" type " *$") →
    - Jika Type1 atau Type2 sesuai dengan tipe yang diberikan, maka baris tersebut akan ditampilkan.


<pre><code>
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
</pre></code>
Merupakan kode untuk menjawab soal 4E dan 4F yang dimana diminta untuk menampilkan help screen dengan command yang diakhiri dengan (-h atau --help).
- Menampilkan petunjuk penggunaan script dengan ASCII art Pokémon sebagai tambahan visual.


<pre><code>
        *)
        echo "Error: Unknown command '$COMMAND'"
        echo "Use -h or --help for more information"
        exit 1
        ;;
esac
</pre></code>
Code yang digunakan untuk menangani perintah yang tidak valid.
- Jika perintah yang diberikan tidak dikenali, maka menampilkan pesan error dan menyarankan penggunaan --help.
