#!/bin/bash

# Duck Local Hosting - Server creation and management wizard for Linux

# Compatible games:
# - SuperTuxKart (Vanilla or kimden code) (WIP)
# - (Laterly) Minecraft Java Edition
# - (Laterly) Minecraft Bedrock

TEMP_FILE=$(mktemp)

function stk_screen
{
	dialog 	--title "Install or configure SuperTuxKart server" \
			--menu "Select an option:" 0 0 2 \
			1 "Go back" \
			2 "Install a new SuperTuxKart server" \
			3 "Configure the .xml of a server" 2> "$TEMP_FILE"
#   (WIP)	4 "Read the database of a server" \
#   (WIP)	5 "Manage the installed add-ons or install more" 
	
	OPTION=$(cat "$TEMP_FILE")
	
	if [ $RETURN_CODE -eq 0 ]; then
	case "$OPTION" in 
		1)  clear; exec $0
		    ;;
		2)  source ./stk_install_server.sh
		    ;;
		3)  source ./stk_xml_config.sh
		    ;;
		*)  dialog --textbox "Error! You choose a inexistent option. Try again." 0 0; sleep 1; exec
		    ;;
	esac
fi
}

dialog 	--title "Welcome to Duck Local Hosting :3" \
		--menu "Select an option:" 0 0 2 \
		1 "About this project" \
		2 "Install or configure SuperTuxKart server" 2> "$TEMP_FILE"

RETURN_CODE=$?

OPTION=$(cat "$TEMP_FILE")

if [ $RETURN_CODE -eq 0 ]; then
	case "$OPTION" in 
		1)  clear; dialog --title "About this project" \
				   --textbox ABOUT 20 65
		    if [ $RETURN_CODE -eq 0 ]; then
				clear; exec $0
	        fi
		    ;;
		2)  clear; stk_screen 
		    ;;
		*)  dialog --textbox "Error! You choose a inexistent option. Try again." 0 0; sleep 1; exec
		    ;;
	esac
fi

if [ $RETURN_CODE -eq 1 ]; then
	clear; exit 1
fi

rm "$TEMP_FILE"