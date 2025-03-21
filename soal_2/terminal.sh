#!/bin/bash

echo "Menu: "
echo "1. register"
echo "2. login"
echo "3. exit"

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


