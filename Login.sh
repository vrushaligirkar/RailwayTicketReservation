#!/bin/bash
loginid=$(zenity --entry --text "Enter login id")
pass=$(zenity --entry --text "Enter password" --hide-text)
count=$(mysql -u user -p1234 <<EOF
USE Railway
SELECT * FROM Registration WHERE Login="$loginid" AND Password="$pass";
EOF
)
while [ "$count" = "" ]
do
zenity --info --title "Sorry!" --text "Wrong login_id or password"
loginid=$(zenity --entry --text "Enter login id")
pass=$(zenity --entry --text "Enter password" --hide-text)
count=$(mysql -u user -p1234 <<EOF
USE Railway
SELECT * FROM Registration WHERE Login="$loginid" AND Password="$pass";
EOF
)
done
chmod 755 Type.sh
./Type.sh


