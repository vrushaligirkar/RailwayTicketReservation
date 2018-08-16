#!/bin/bash

zenity --info --title "Hello" --text "Hi! Welcome to Indian Railways...!!!"

value=$(zenity --list --text  "Registration" --column "Select" Register Login)

if [ $value = "Register" ]; then

	chmod 755 Register.sh

	./Register.sh

fi

if [ $value = "Login" ]; then

	chmod 755 Login.sh
	
	./Login.sh
fi
