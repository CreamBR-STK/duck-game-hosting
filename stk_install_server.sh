#!/bin/bash

# Duck Game Hosting - Server creation and management wizard for Linux

# Script for SuperTuxKart server install

TEMP_FILE=$(mktemp)

function install_deps
{
	dialog --title "Server installation" \
		   --textbox "You need to install some dependencies to compile SuperTuxKart" 0 0

	dialog --title "Server installation" \
		   --menu "What's your distro?" 0 0 4\
		   deb "Debian-based distros (Debian, Ubuntu...)" \
		   rpm "Fedora-based distros (Fedora, CentOS...)" \
		   arch "Arch-based distros (Arch Linux, Manjaro...)" \
		   suse "openSUSE-based distros (openSUSE, RegataOS...)"2> "$TEMP_FILE"
		   
	OPTION=$(cat "$TEMP_FILE")
	
	RETURN_CODE=$?
}

function select_install
{
	dialog --title "Server installation" \
		   --menu "What you want to do?" 0 0 2\
		   game "Install/Compile the game" \
		   server "Add a server" 2> "$TEMP_FILE"
		   
	OPTION=$(cat "$TEMP_FILE")
	
	RETURN_CODE=$?
	
	if [ $RETURN_CODE -eq 0 ]; then
	case "$OPTION" in 
		game)   clear; install_deps
				;;
		server) clear; clear; echo "Nothin yet :P"
				;;
		*)      dialog --textbox "Error! You choose a inexistent option. Try again." 0 0; sleep 1; select_install
		    ;;
	esac
fi

	if [ $RETURN_CODE -eq 1 ]; then
		clear; ./duck-game.sh
	fi
}

clear

select_install

rm "$TEMP_FILE"