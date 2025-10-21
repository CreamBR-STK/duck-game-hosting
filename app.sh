#!/bin/bash

# Duck Local Hosting - Host a game server on Termux

# Compatible games:
# - SuperTuxKart (Vanilla or kimden code) (WIP)
# - Minecraft Java Edition (WIP)
# - (Laterly) Minecraft Bedrock

# GPL License

echo Welcome to Duck Local Hosting :3
echo Pick an option:
echo 1. Install or configure SuperTuxKart server
echo 2. Install or configure MC Java server
echo 3. About this project
read option

case "$option" in 
	1) ./stk_screen.sh
	2) ./mc_java_screen.sh
	3) ./about.sh
	*) Error! You choose a inexistent option. Try again.