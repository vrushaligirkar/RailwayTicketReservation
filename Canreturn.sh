#!/bin/bash
zenity --info --text "Enter Passenger details"
date1=$(zenity --calendar --title "Cancelation" --text "Select your journey date" --date-format="%Y-%m-%d")
date2=$(zenity --calendar --title "Cancelation" --text "Select your return date" --date-format="%Y-%m-%d")

fromm=$(zenity  --list  --text "From" --radiolist  --column "Pick" --column "City" FALSE Mumbai FALSE Delhi FALSE Chennai FALSE Kolkata FALSE Bangalore)

too=$(zenity  --list  --text "To" --radiolist  --column "Pick" --column "City" FALSE Mumbai FALSE Delhi FALSE Chennai FALSE Kolkata FALSE Bangalore)

em=$(zenity --entry --text "Email address")

valid=$(mysql -u user -p1234 <<EOF
USE Railway
SELECT * FROM Ret1 WHERE s_date='$date1' and r_date='$date2' and rsource='$fromm' and rdestination='$too' and email_id='$em';
EOF
)
if [ "$valid" = "" ]; then
zenity -info --title "Failed" --text "No such reservation found"
else
mysql -u user -p1234 <<EOF
USE Railway
DELETE FROM Ret1 WHERE s_date='$date1' and r_date='$date2' and rsource='$fromm' and rdestination='$too' and email_id='$em';		
EOF
zenity --info --text "Tickect cancelation successful"
fi
