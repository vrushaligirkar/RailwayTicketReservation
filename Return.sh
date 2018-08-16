now=$(date +"%s")
date1=$(zenity --calendar --title "Booking" --text "Select your journey date" --date-format="%Y-%m-%d")
dt1=$(date -d $date1 "+%s")
while [ $now -ge $dt1 ]
do
zenity --error --text "Select proper date"
date1=$(zenity --calendar --title "Booking" --text "Select your journey date" --date-format="%Y-%m-%d")
dt1=$(date -d $date1 "+%s")
done
date2=$(zenity --calendar --title "Booking" --text "Select your return date" --date-format="%Y-%m-%d")
dt2=$(date -d $date2 "+%s")
while [ $dt1 -ge $dt2 ]
do
zenity --error --text "Select proper date"
date2=$(zenity --calendar --title "Booking" --text "Select your return date after start date" --date-format="%Y-%m-%d")
dt2=$(date -d $date2 "+%s")
done
fromm=$(zenity  --list  --text "From" --radiolist  --column "Pick" --column "City" FALSE Mumbai FALSE Delhi FALSE Chennai FALSE Kolkata FALSE Bangalore)
too=$(zenity  --list  --text "To" --radiolist  --column "Pick" --column "City" FALSE Mumbai FALSE Delhi FALSE Chennai FALSE Kolkata FALSE Bangalore)
while [ $fromm = $too ]
do
zenity --error --text "Same source and destination. Please select again"
fromm=$(zenity  --list  --text "From" --radiolist  --column "Pick" --column "City" FALSE Mumbai FALSE Delhi FALSE Chennai FALSE Kolkata FALSE Bangalore)
too=$(zenity  --list  --text "To" --radiolist  --column "Pick" --column "City" FALSE Mumbai FALSE Delhi FALSE Chennai FALSE Kolkata FALSE)
done
if [ $fromm = "Mumbai" ]; then
	case $too in
		"Delhi") cost=1700;;
		"Chennai") cost=1700;;
		"Kolkata") cost=2000;;
		"Bangalore") cost=1500;;
	esac
fi

if [ $fromm = "Delhi" ]; then
	case $too in
		"Mumbai") cost=1700;;
		"Chennai") cost=2300;;
		"Kolkata") cost=1500;;
		"Bangalore") cost=2200;;
	esac
fi

if [ $fromm = "Chennai" ]; then
	case $too in
		"Mumbai") cost=1700;;
		"Delhi") cost=2300;;
		"Kolkata") cost=1800;;
		"Bangalore") cost=1000;;
	esac
fi

if [ $fromm = "Kolkata" ]; then
	case $too in
		"Mumbai") cost=2000;;
		"Delhi") cost=1500;;
		"Chennai") cost=1800;;
		"Bangalore") cost=2000;;
	esac
fi

if [ $fromm = "Bangalore" ]; then
	case $too in
		"Mumbai") cost=1500;;
		"Delhi") cost=2200;;
		"Chennai") cost=1000;;
		"Kolkata") cost=2000;;
	esac
fi
ticket=$(zenity --entry --text "Enter number of tickets")
ticket1=$(($(($ticket)) * 2))
tick=$ticket
zenity --info --text "Passenger Details"
while [ $tick != "0" ]
do
fname=$(zenity --entry --text "First name")
while [ "$fname" = "" ] || [[ "$fname" =~ ^[^a-zA-Z]+$ ]]
do
	zenity --error --text "Name not entered."
	fname=$(zenity --entry --text "Enter your first name")
done
lname=$(zenity --entry --text "Last name")
while [ "$lname" = "" ] || [[ "$lname" =~ ^[^a-zA-Z]+$ ]]
do
	zenity --error --text "Name not entered."
	lname=$(zenity --entry --text "Enter your last name")
done
email=$(zenity --entry --text "Email address")
contact=$(zenity --entry --text "Contact number")
while [[ "$contact" =~ ^[^0-9]+$ ]]
do
	zenity --error --text "Invalid number"
	contact=$(zenity --entry --text "Enter contact number")
done
mysql -u user -p1234 <<EOF
USE Railway
INSERT INTO Ret1 values('$date1','$date2','$fromm','$too','$fname','$lname','$email','$contact');
EOF
tick=$(($tick-1))
done
zenity --info --text "Journey fare of one ticket is Rs.$cost"
amount=$(($(($cost)) * $(($ticket1))))
zenity --info --text "Total amount to be paid  for $ticket passengers is Rs.$amount"


