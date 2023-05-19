#!/bin/bash

# Basic imports

option=$1
parameter=$2
parameter2=$3

disable_done=False


bold=$(tput bold)
normal=$(tput sgr0)

Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Functions

# Progress bar
ProgressBar(){
for i in {1..100}; do
	output="\r"

	output="$output ["
	total=$i
	count=0

	while [ $count -lt $total ]; do
		output="$output▰"
		let count=$count+3
	done

	let total=100-$total
	count=0

	while [ $count -lt $total ]; do
		output="$output▱" 
		let count=$count+3
	done
	output="$output ] $i%"
	echo -ne "$output"

	sleep .01
done

echo -e " ${BGreen}✔ "
}

# YAML parser

function parse_yaml {
      local prefix=$2
      local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo -e @|tr @ '\034')
      sed -ne "s|^\($s\):|\1|" \
            -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
            -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
      awk -F$fs '{
            indent = length($1)/2;
            vname[indent] = $2;
            for (i in vname) {if (i > indent) {delete vname[i]}}
            if (length($3) > 0) {
                  vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
                  printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
            }
      }'
}

eval "$(parse_yaml $HOME/cromha-manager-config.yaml "CONFIG_")"

# Informations variables
version_ver=0.1

# Package managers variables
flatpak_check=$(echo -e "$CONFIG_package_managers_flatpak")
flatpak=$(echo -e $flatpak_check)
snap_check=$(echo -e "$CONFIG_package_managers_snapcraft")
snap=$(echo -e $snap_check)
yum_check=$(echo -e "$CONFIG_package_managers_yum")
yum=$(echo -e $yum_check)
pacman_check=$(echo -e "$CONFIG_package_managers_pacman")
pacman=$(echo -e $pacman_check)
cargo_check=$(echo -e "$CONFIG_package_managers_cargo")
cargo=$(echo -e $cargo_check)
dnf_check=$(echo -e "$CONFIG_package_managers_dnf")
dnf=$(echo -e $dnf_check)
apt_check=$(echo -e "$CONFIG_package_managers_apt")
apt=$(echo -e $apt_check)
zypp_check=$(echo -e "$CONFIG_package_managers_zypp")
zypp=$(echo -e $zypp_check)

if [ "$option" == "" ]; then
      echo -e  "${BRed}_________                       .__            
\_   ___ \_______  ____   _____ |  |__ _____   
/    \  \/\_  __ \/  _ \ /     \|  |  \\__  \  
\     \____|  | \(  <_> )  Y Y  \   Y  \/ __ \_
 \______  /|__|   \____/|__|_|  /___|  (____  /
        \/                    \/     \/     \/ 
${Color_Off}"
      echo -e " "
      echo -e "${BCyan}=====================================================================${normal}"
      echo -e  "${BPurple}Github Repository${Color_Off}: ${BBlue}https://github.com/OcelotWalrus/Bash-Multi-Package-Manager${Color_Off}"
      echo -e " "
      echo -e  "${Green}Current version${Color_Off}: ${BYellow}$version_ver${Color_Off}"
      echo -e "${BCyan}=====================================================================${normal}"
      echo -e " "
      echo -e  "${Cyan}A bash script to manage multiple package
managers easily with high customizability.${Color_Off}"
      echo -e " "
      echo -e " "

fi

sleep 1
echo "Do you want to install cromha-manager-ctl and cromha-manager?(y/n)"
read answer

if [ "$answer" == "y" ]; then

      echo -e "Installing Cromha Multi Package Manager..."
      FILE=$HOME/cromha-manager-config.yaml
	if test -f "$FILE"; then
		sudo cp src/cromha-manager /usr/bin/
            sudo cp src/cromha-manager-ctl /usr/bin/
	else
		cp src/cromha-manager-config.yaml $HOME/
            chmod 777 $HOME/cromha-manager-config.yaml
            echo -e "Opening config file with nano to edit it..."
            sleep 1
            echo -e "Please set up the config file for you, if you have any question, check ${BBlue}https://github.com/OcelotWalrus/Bash-Multi-Package-Manager${Color_Off}"
            sleep 3
            nano $HOME/cromha-manager-config.yaml
            sudo cp src/cromha-manager /usr/bin/
            sudo cp src/cromha-manager-ctl /usr/bin/
            echo ""
	fi
      echo "[Finishing Installation]"
      ProgressBar

else
      echo -e "Aborting installing Cromha Multi Package Manager..."
      sleep 1
fi
