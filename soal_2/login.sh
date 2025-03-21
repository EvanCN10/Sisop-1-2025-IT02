#!/bin/bash

database="/home/binar/soal2/data/player.csv"

echo "masukkan email: "
read email
if ! grep -q "^$email," /home/binar/soal2/data/player.csv; then
    echo "email tidak terdaftar"
    exit 1
fi

echo "masukkan password: "
read -s password

salt="1234"
hashed_password=$(echo -n "$salt$password" | sha256sum | awk '{print $1}')

if grep -q "^$email,.*,${hashed_password}$" "$database"; then
    username=$(grep "^$email," "$database" | awk -F',' '{print $2}')
    echo "Login sukses!"
    echo "selamat datang $username"
else
    echo "Invalid email atau password!"
    exit 1
fi
