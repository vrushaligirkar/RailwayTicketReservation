#!/bin/bash

fname=$(zenity --entry --text "First name")

while [ "$fname" = "" ] || [[ "$fname" =~ ^[^a-zA-Z]+$ ]]

do
	zenity --error --text "First name not entered properly!!"

	fname=$(zenity --entry --text "Enter first name")

done



lname=$(zenity --entry --text "Last name")

while [ "$lname" = "" ] || [[ "$lname" =~ ^[^a-zA-Z]+$ ]]

do
	zenity --error --text "Last name not entered properly!!"

	lname=$(zenity --entry --text "Enter Last name")

done



email=$(zenity --entry --text "Email address")



contact=$(zenity --entry --text "Contact number")

while [[ "$contact" =~ ^[^0-9]+$ ]]

do
	zenity --error --text "Invalid number"

	contact=$(zenity --entry --text "Enter contact number")

done


loginid=$(zenity --entry --text "Enter login id")

while [ "$loginid" = "" ]

do
	zenity --error --text "Id not entered!!"

	loginid=$(zenity --entry --text "Enter Login id")

done


password=$(zenity --entry --text "Enter password" --hide-text)

password1=$(zenity --entry --text "Re-enter password" --hide-text)

while [ "$password" -ne "$password1" ]

do

zenity --error --text "Password not entered properly"

password=$(zenity --entry --text "Enter password" --hide-text)

password1=$(zenity --entry --text "Re-enter password" --hide-text)

done


mysql -u user -p1234 <<EOF

USE Railway

INSERT INTO Registration values('$fname','$lname','$email','$contact','$loginid','$password');

EOF

zenity --info --title "Success!!" --text "Registration Successful"

chmod 755 Type.sh

./Type.sh
