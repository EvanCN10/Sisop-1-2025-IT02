# Soal 1
0
# Soal 2
1. register.sh (Registrasi Player)
   
<pre><code>
#!/bin/bash
</code></pre>
(#!/bin/bash) Menunjukkan bahwa skrip ini akan dijalankan menggunakan Bash.

<pre><code>
DB_FILE="/data/player.csv"
</code></pre>
Menentukan lokasi file database tempat semua "Player" akan disimpan.

<pre><code>
read -p "Enter email: " email
read -p "Enter username: " username
read -s -p "Enter password: " password
</code></pre>
read -p "..." variable : Membaca input pengguna.
-s untuk password menyembunyikan input agar tidak terlihat di layar.

<pre><code>
echo
</code></pre>
menambahkan baris kosong untuk meningkatkan keterbacaan output di terminal.

Validasi Email
<pre><code>
if ! [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Invalid email format!"; exit 1
fi
</code></pre>
Memeriksa apakah format email valid menggunakan regular expression (regex):
1. Harus mengandung @ dan .
2. Domain email minimal memiliki dua huruf setelah titik (.com, .id, dll.).
Jika tidak valid, program menampilkan "Invalid email format!" lalu keluar (exit 1).

Validasi Password
<pre><code>
if [[ ${#password} -lt 8 || "$password" != *[a-z]* || "$password" != *[A-Z]* || "$password" != *[0-9]* ]]; then
    echo "Password must be at least 8 characters, include uppercase, lowercase, and a number!"; exit 1
fi
</code></pre>
if [[ ... ]] melakukan pengecekan kondisi:
1. ${#password} -lt 8 -> Password harus minimal 8 karakter.
2. "$password" != *[a-z]* -> Harus mengandung huruf kecil.
3. "$password" != *[A-Z]* -> Harus mengandung huruf besar.
4. "$password" != *[0-9]* -> Harus mengandung angka.
Jika tidak memenuhi kriteria, tampilkan pesan error dan keluar.

Cek Apakah Email Sudah Terdaftar
<pre><code>
if grep -q "^$email," "$DB_FILE"; then
    echo "Email already registered!"; exit 1
fi
</code></pre>
1. grep -q "^$email," "$DB_FILE"  Mencari apakah email sudah ada di database (player.csv).
2. ^ menandakan pencarian dari awal baris.
3. Jika sudah ada, program menampilkan "Email already registered!" lalu keluar.

Hashing Password dan Menyimpan ke Database
<pre><code>
echo "$email,$username,$(echo -n "$password:salt123" | sha256sum | awk '{print $1}')" >> "$DB_FILE"
</code></pre>
Hashing password menggunakan SHA-256 dengan static salt (salt123):
1. echo -n "$password:salt123" | sha256sum | awk '{print $1}'
2. -n mencegah tambahan newline.
3. sha256sum mengenkripsi password.
4. awk '{print $1}' hanya mengambil hash (tanpa tanda - tambahan).

<pre><code>
email,username,hashed_password
</code></pre>
Format penyimpanan ke database

<pre><code>
>> "$DB_FILE" 
</code></pre>
Menambahkan data ke akhir file tanpa menghapus data lama.

<pre><code>
echo "Registration successful!"
</code></pre>
Memberi konfirmasi bahwa registrasi berhasil.


2. login.sh (Login Player)
<pre><code>
#!/bin/bash
</code></pre>
menandakan bahwa ini adalah skrip Bash.

<pre><code>
DB_FILE="/data/player.csv"
</code></pre>
Menentukan lokasi file database.

<pre><code>
read -p "Enter email: " email
read -s -p "Enter password: " password
</code></pre>
Meminta pengguna memasukkan email dan password.
-s menyembunyikan input password.

<pre><code>
echo
</code></pre>
Menambahkan baris kosong untuk tampilan yang lebih rapi.

<pre><code>
hashed_password=$(echo -n "$password:salt123" | sha256sum | awk '{print $1}')
</code></pre>
Hashing password input dengan metode yang sama seperti saat registrasi.

Cek Kredensial di Database
<pre><code>
if grep -q "^$email,.*,$hashed_password$" "$DB_FILE"; then
    echo "Login successful!"
else
    echo "Invalid email or password!"
fi
</code></pre>
grep -q "^$email,.*,$hashed_password$" "$DB_FILE":
1. Mencari email yang cocok.
2. .* mencocokkan username (karena tidak dicek dalam login).
3. "$hashed_password$" memastikan password cocok.
Jika ditemukan, tampilkan "Login successful!", jika tidak, tampilkan "Invalid email or password!".


3. terminal.sh (menu)
<pre><code>
echo "=== Arcaea System ==="
echo "1. Register"
echo "2. Login"
echo "3. Exit"
</code></pre>
menampilkan menu

<pre><code>
read -p "Choose an option: " choice
</code></pre>
Meminta pengguna memilih opsi.

<pre><code>
case $choice in
    1) ./scripts/register.sh ;;
    2) ./scripts/login.sh ;;
    3) exit 0 ;;
    *) echo "Invalid option!" ;;
esac
</code></pre>
Jika pengguna memilih:
1. -> Jalankan register.sh.
2. -> Jalankan login.sh.
3. -> Keluar dari program.
Selain itu -> Tampilkan pesan error "Invalid option!".
    
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
        head -n 1 "$FILENAME"
        tail -n +2 "$FILENAME" | sort -t, -k2,2nr
        ;;
</pre></code>
Merupakan kode untuk menjawab soal 4B yang dimana ingin mengurutkan pokemon berdasarkan kolom tertentu dengan command yang diakhiri (--sort).
- Memeriksa apakah argumen kolom pengurutan ($3) disertakan. Jika tidak, ditampilkan error.
- Menggunakan sort untuk mengurutkan Pokémon berdasarkan kolom yang diberikan.
- head -n 1 digunakan untuk menampilkan header.
- tail -n +2 digunakan untuk melewati header dan mengurutkan data berdasarkan kolom kedua dalam urutan menurun (descending) (-k2,2nr).


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
        head -n 1 "$FILENAME"
        awk -F',' -v type="$POKEMON_TYPE" 'NR==1 || $4==type || $5==type' "$FILENAME" | sort -t, -k2,2nr
        ;;
</pre></code>
Merupakan kode untuk menjawab soal 4D yang dimana ingin menyaring pokemon berdasarkan tipe tertentu dengan command yang diakhiri (--filter).
- Memeriksa apakah tipe Pokémon ($3) diberikan, jika tidak, menampilkan error.
- awk digunakan untuk menampilkan Pokémon yang memiliki tipe sesuai dengan kolom ke-4 atau ke-5 dalam CSV.
- Hasilnya diurutkan berdasarkan penggunaan tertinggi.


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
