cat << 'EOF' > ./scripts/register.sh
#!/bin/bash
DB_FILE="./data/player.csv"

read -p "Enter email: " email
read -p "Enter username: " username
read -s -p "Enter password: " password

if ! [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Invalid email format!"; exit 1
fi

if [[ ${#password} -lt 8 || "$password" != [a-z] || "$password" != [A-Z] || "$password" != [0-9] ]]; then
    echo "Password must be at least 8 characters, with uppercase, lowercase, and a number!"; exit 1
fi

if grep -q "^$email," "$DB_FILE"; then
    echo "Email already registered!"; exit 1
fi

echo "$email,$username,$(echo -n "$password:salt123" | sha256sum | awk '{print $1}')" >> "$DB_FILE"
echo "Registration successful!"
EOF
