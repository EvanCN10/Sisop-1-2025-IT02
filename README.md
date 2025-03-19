# Soal 1
0
# Soal 2
0
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
