#! /bin/bash

user_file=~/.git-user

echo -n "Git user name: "
read name || exit 1

echo -n "Git user email: "
read email || exit 1

echo "[user]" > $user_file
echo "  name = $name" >> $user_file
echo "  email = $email" >> $user_file
