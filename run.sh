#!/bin/bash

read -s -p "Password: " pass1
printf "\n"

if [ $1 == "encrypt" ]; then
  read -s -p "Re-Password: " pass2
  printf "\n"
  if [ "$pass1" != "$pass2" ]; then
    printf "\nPasswords don't match\n";
    exit 0
  fi
fi

echo $pass1 > ~/.ansible/pass.txt

shopt -s dotglob

cd "$VAULT_PATH"

for file in *; do
  if [ -f "$file" ]; then
    ansible-vault $1 "$file" --vault-password-file ~/.ansible/pass.txt
  fi
done

shopt -u dotglob

rm -f ~/.ansible/pass.txt
