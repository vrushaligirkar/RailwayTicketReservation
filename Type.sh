type=$(zenity --list --text  "Journey type" --column "Type" One-Way Return Cancelation)
if [ $type = "One-Way" ]; then
	chmod 755 Oneway.sh
	./Oneway.sh
fi
if [ $type = "Return" ]; then
	chmod 755 Return.sh
	./Return.sh
fi
if [ $type = "Cancelation" ]; then
	chmod 755 Cancel.sh
	./Cancel.sh
fi
