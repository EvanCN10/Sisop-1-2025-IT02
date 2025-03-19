# Soal 1
0
# Soal 2
0
# Soal 3
<pre><code>
#!/bin/bash
clear
</code></pre>

<pre><code>
speak_to_me() {
    while true; do
        curl -s https://www.affirmations.dev | jq -r '.affirmation'
        sleep 1
    done
}
</code></pre>

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

<pre><code>
brain_damage() {
    while true; do
        clear
        ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | awk '{printf "%-7s %-10s %-6s %-6s %s\n", $1, $2, $3, $4, $5}' | head -n 20
        sleep 1
    done
}
</code></pre>

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
