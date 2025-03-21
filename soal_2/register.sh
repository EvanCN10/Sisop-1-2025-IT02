#!/bin/bash

database="/home/binar/soal2/data/player.csv"

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

if grep -q "^$email," "$database"; then
    echo "email sudah terdaftar"
    exit 1
fi

echo " "
echo "masukkan username: "
read username

echo " "
echo "masukkan password (gunakan min. 8 char, kapital, angka): "
read -s password
if [[ $password =~ [A-Z] && $password =~ [a-z] && $password =~ [0-9] && ${#password} -ge 8 ]]; then
    echo "password valid"
else
    echo "password invalid"
    exit 1
fi


salt="1234"
hashed_password=$(echo -n "$salt$password" | sha256sum | awk '{print $1}')
password=$hashed_password

echo " " 
echo "$email,$username,$password" >> $database
echo "selamat datang $username"
