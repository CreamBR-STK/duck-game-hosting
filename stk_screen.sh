#!/bin/bash

# Duck Local Hosting - Host a game server on Termux

# stk_screen.sh: Open the SuperTuxKart server configurator

# GPL License

echo SuperTuxKart configurator
echo Pick an option:
echo 1. Install a new SuperTuxKart server
echo 2. Configure the .xml of a server
echo 3. Read the database of a server
echo 4. Go back
read option

case "$option" in 
	1) ./stk/install_server.sh
	2) ./stk/xml_config.sh
	3) ./stk/db_reader.sh
	4) ./app.sh
	*) Error! You choose a inexistent option. Try again.