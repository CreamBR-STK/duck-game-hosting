#!/bin/bash

# Duck Local Hosting - Host a game server on Termux

# mc_java_screen.sh: Open the Minecraft Java server configurator

# GPL License

echo Minecraft Java configurator
echo Pick an option:
echo 1. Install a new MC Java server
echo 2. Configure the server.properties of a server
echo 3. Add worlds or mods on a server
echo 4. Go back
read option

case "$option" in 
	1) ./mc-java/install_server.sh
	2) ./mc-java/server_config.sh
	3) ./mc-java/assets_editor.sh
	4) ./app.sh
	*) Error! You choose a inexistent option. Try again.