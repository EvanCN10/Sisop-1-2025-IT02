echo "=== Arcaea System ==="
echo "1. Register"
echo "2. Login"
echo "3. Exit"
read -p "Choose an option: " choice
case $choice in
    1) ./scripts/register.sh ;;
    2) ./scripts/login.sh ;;
    3) exit 0 ;;
    *) echo "Invalid option!" ;;
esac
