#!/bin/bash
zenity --info --text "Cancel Tickets"
ticket=$(zenity --entry --text "Enter number of tickets you want to cancel")
tick=$ticket
while [ $tick != "0" ]
do
type1=$(zenity --list --text "Journey type" --column "Select type" One-Way Return)
if [ $type1 = "One-Way" ]; then
	chmod 755 Canoneway.sh
	./Canoneway.sh	
fi
if [ $type1 = "Return" ]; then
	chmod 755 Canreturn.sh
	./Canreturn.sh
fi
tick=$(($tick-1))
done
