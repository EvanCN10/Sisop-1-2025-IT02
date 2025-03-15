cat << 'EOF' > ./scripts/login.sh
#!/bin/bash
DB_FILE="./data/player.csv"

read -p "Enter email: " email
read -s -p "Enter password: " password

hashed_password=$(echo -n "$password:salt123" | sha256sum | awk '{print $1}')

if grep -q "^$email,.*,${hashed_password}$" "$DB_FILE"; then
    echo "Login successful!"
else
    echo "Invalid email or password!"
fi
EOF
