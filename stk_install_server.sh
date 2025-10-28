#!/bin/bash

# Duck Game Hosting - Server creation and management wizard for Linux

# Script for SuperTuxKart server install

TEMP_FILE=$(mktemp)

function root_before_install
{
	clear; touch install.log
	if [ "$EUID" -ne 0 ]; then
		dialog --title "Install deps" \
		--passwordbox "Please, enter your root password" 0 0 2> "$TEMP_FILE"
		echo "$(cat "$TEMP_FILE")" | sudo -S -v
		rm -f "$TEMP_FILE" 2>/dev/null
	fi
}


function install_deps
{
	dialog --title "Info" \
		   --title "Server installation" \
		   --msgbox "You need to install some dependencies to compile SuperTuxKart" 0 0 \
		   --and-widget \
		   --menu "What's your distro?" 0 0 4 \
		   deb "Debian-based distros (Debian, Ubuntu...)" \
		   rpm "Fedora-based distros (Fedora, CentOS...)" \
		   arch "Arch-based distros (Arch Linux, Manjaro...)" \
		   suse "openSUSE-based distros (openSUSE, RegataOS...)" 2> "$TEMP_FILE"
		   
	OPTION=$(cat "$TEMP_FILE")  
	
	RETURN_CODE=$?
	
		if [ $RETURN_CODE -eq 0 ]; then
	case "$OPTION" in 
		deb)    clear; root_before_install
				dialog --title "Install deps" --textbox install.log 20 65 && \
				apt-get install build-essential cmake libbluetooth-dev libsdl2-dev \
				libcurl4-openssl-dev libenet-dev libfreetype6-dev libharfbuzz-dev \
				libjpeg-dev libogg-dev libopenal-dev libpng-dev \
				libssl-dev libvorbis-dev libmbedtls-dev pkg-config zlib1g-dev \
				git subversion sqlite3 libsqlite3-dev
				;;
		rpm)    clear; root_before_install
				dialog --title "Install deps" --textbox install_deps.log 20 65 && \
				dnf install @development-tools angelscript-devel \
				bluez-libs-devel cmake desktop-file-utils SDL2-devel \
				freealut-devel freetype-devel \
				gcc-c++ git-core libcurl-devel libjpeg-turbo-devel \
				libpng-devel libsquish-devel libtool libvorbis-devel \
				openal-soft-devel openssl-devel libcurl-devel harfbuzz-devel \
				libogg-devel openssl-devel pkgconf \
				wiiuse-devel zlib-devel \ 
				sqlite3 sqlite-devel
				;;
		arch)   clear; root_before_install
				dialog --title "Install deps" --textbox install_deps.log 20 65 && \
				pacman -S openal libogg libvorbis freetype2 harfbuzz curl \
				bluez-libs openssl libpng zlib libjpeg-turbo sdl2 gcc cmake \
				pkgconf make git subversion sqlite
				;;
		suse)   clear; root_before_install
				dialog --title "Install deps" --textbox install_deps.log 20 65 && \
				zypper install gcc-c++ cmake openssl-devel libcurl-devel libSDL2-devel \
				freetype-devel harfbuzz-devel libogg-devel openal-soft-devel libpng-devel \
				libvorbis-devel pkgconf zlib-devel enet-devel \
				libjpeg-devel bluez-devel freetype2-devel \
				sqlite3 sqlite3-devel
				;;
		*)      dialog --textbox "Error! You choose a inexistent option. Try again." 0 0; sleep 1; select_install
		    ;;
	esac
fi

	if [ $RETURN_CODE -eq 1 ]; then
		clear; select_install
	fi
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