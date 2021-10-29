user_file=~/.git-user

echo -n "Git user name: "
read name
echo -n "Git user email: "
read email

echo "[user]" > $user_file
echo "  name = $name" >> $user_file
echo "  email = $email" >> $user_file
