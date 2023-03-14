#!/bin/bash

useColor="true"

# Font Color
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
ORANGE='\033[1;33m'
UNDERLINE='\033[0;4m'
NOCOLOR='\033[0m'
DARKRED='\033[0;31m'
DARKGREY='\033[1;90m'
MAGENTA='\033[1;95m'
WHITE='	\033[97m'
DARKGREEN='\033[32m'

clear

echo -e  "\t\t💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀" 
echo -e "\t\t💀\t\t${ORANGE}Network Research Project ${CYAN}Version 1${RED}\t\t\t💀"  
echo -e "\t\t💀\t\t ${MAGENTA}Done by Leonard Yeo (S8)\t\t\t\t💀"
echo -e  "\t\t💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀"
echo -e "\n"
echo -e "\n"

sleep 1

echo -e "${DARKGREEN}Checking if required tools are installed...." 

{
	if [ $(dpkg-query -l | grep '^ii' | awk '{print $2}' | grep -x tor) == "tor" ];
	then
	
	echo -e "${WHITE}[#] tor is already installed " 
	
	else 
	
	echo -e " ${RED}Installing ToriFY..."
	
	git clone https://github.com/Debajyoti0-0/ToriFY.git
	sudo pip3 install -r requirements.txt
	chmod +x *
    sudo ./install.sh
	fi
	
}
{
	
	if [ $(dpkg-query -l | grep '^ii' | awk '{print $2}' | grep -x geoip-bin) == "geoip-bin" ];
	then
	
	echo -e "${WHITE}[#] geoip-bin is already installed" 
	
	else
	
	echo -e "${RED}Installing geoip-bin..."
	sudo apt-get install geoip-bin
	
	fi
}
{
if [ $(dpkg-query -l | grep '^ii' | awk '{print $2}' | grep -x sshpass) == "sshpass" ];
	then
	
	echo -e "${WHITE}[#] sshpass is already installed" 
	
	else
	
	echo -e "${RED}Installing sshpass..."
	sudo apt-get install sshpass
	
	
	fi
}	
{
if [ $(dpkg-query -l | grep '^ii' | awk '{print $2}' | grep -x whois) == "whois" ];
	then
	
	echo -e "${WHITE}[#] whois is already installed" 
	
	else
	
	echo -e "${RED}Installing whois..."
	sudo apt-get install whois
	echo -e "${WHITE}[#] whois is already installed" 
	
	fi
}	
{
if [ $(dpkg-query -l | grep '^ii' | awk '{print $2}' | grep -x nmap) == "nmap" ];
	then
	
	echo -e "${WHITE}[#] nmap is already installed" 
	
	else
	
	echo -e "${RED}Installing nmap..."
	sudo apt-get install nmap
	
	
	fi
}	
{
if [ $(find ./ -name "nipe.pl") == "./nipe/nipe.pl" ];
	then

	
	echo -e "${WHITE}[#] Nipe is already installed" 
	
	else
	
	git clone https://github.com/htrgouvea/nipe
    cd "$(dirname "$(find ./ -name "nipe.pl")")" && sudo cpan install Try::Tiny Config::Simple JSON
    cd "$(dirname "$(find ./ -name "nipe.pl")")" && sudo perl nipe.pl install
	
	fi
}		

MYIP=$(curl -s ifconfig.me/ip)

cd "$(dirname "$(find ./ -name "nipe.pl")")" && sudo perl nipe.pl start && sudo perl nipe.pl restart
NIP=$(cd "$(dirname "$(find ./ -name "nipe.pl")")" && sudo perl nipe.pl status | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
{
if [ "$MYIP" = "$NIP" ];

	then

	echo -e "${RED} NOT ANOYMOUS! EXITING NOW."

	exit 0
	
	else
	
echo -e "${CYAN}your Spoofed IP Address is '${WHITE}$NIP', ""${CYAN}Country of Spoofed IP is: " ${WHITE}$(geoiplookup $NIP | grep -oP '(?<=: ).*')

fi
}

echo "Specify a Domain/IP address to scan: " 

read input1 

cd - > /dev/null 2>&1

sshpass -p 'tc' ssh tc@192.168.220.131 'echo "${CYAN}Connecting to Remote Server:"'
echo -e "${CYAN}Uptime: ${WHITE}$(uptime)"
echo -e "${CYAN}IP Address:${WHITE}$(curl -s ifconfig.me/ip)"
RIPADD=$(curl -s ifconfig.me/ip)
echo -e "${CYAN}Country: ${WHITE}$(geoiplookup $RIPADD| grep -oP '(?<=: ).*')"

echo -e "${CYAN}[@] Whoising Victim's Address:"
echo -e "${MAGENTA}Whois data was saved into $(pwd)/whois_$input1.txt"
whois $input1 >> whois_$input1.txt
echo "$(TZ="Singapore" date) - [*] whois data is collected for $input1 " >> NR.log

echo -e "${CYAN}[@] Scanning Victim's Address:"
echo -e "${MAGENTA}Nmap scan was saved into $(pwd)/nmap_$input1.txt"
nmap $input1 >> nmap_$input1.txt
echo "$(TZ="Singapore" date) - [*] nmap data is collected for $input1 " >> NR.log

echo -e "${GREEN}whois & namp log time added to NR.log" 

echo -e "${RED} Script End "
