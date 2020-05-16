#!/bin/bash

###
#
# ./phpError.sh : Used to enable/disable display Error on php  
#
###

# get the php version
ver=`php --version | grep -m1 PHP | cut -d" " -f2 | cut -d. -f1,2`
# path of php.ini file
OrPath=`echo /etc/php/$ver/apache2/php.ini`
BkPath=` echo /etc/php/$ver/apache2/php.ini.bak`

# some variables setting for colorful output
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

function CreateBackup {
	if [ ! -f $Bkpath ]
	then
		cp $OrPath $BkPath
		echo "${red}[*]${reset} Backup file created."
	else
		echo "${red}[-]${reset} Backup file already exists."
	fi
}

function EnableErr {
	echo "${red}[+]${reset} Creating backup file"
	CreateBackup
	cat $OrPath | awk '{if($0=="display_errors = Off"){print "display_errors = On"}else{print $0}}' > /tmp/php.ini.bak
	cp /tmp/php.ini.bak $OrPath
	rm /tmp/php.ini.bak
	echo "${red}[+]${reset} display_error Enabled : ${green}Success${reset}"
	echo "${red}[+]${reset} Restarting apache server"
	/etc/init.d/apache2 restart
}

function DisableErr {
	echo "${red}[+]${reset} Creating backup file"
	CreateBackup
	cat $OrPath | awk '{if($0=="display_errors = On"){print "display_errors = Off"}else{print $0}}' > /tmp/php.ini.bak
	cp /tmp/php.ini.bak $OrPath
	rm /tmp/php.ini.bak
	echo "${red}[+]${reset} display_error Disabled : ${green}Success${reset}"
	echo "${red}[+]${reset} Restarting apache server"
	/etc/init.d/apache2 restart
}

function main {
	if [ -z $1 ]
	then
		echo "${green}Usages :${reset}"
		echo -e "\t$0 -e/-d"
		echo "${red}\"-e\"${reset} - Enable Display_Error"
		echo "${red}\"-d\"${reset} - Disable Display_Error"
	elif [ "$1" == "-e" ] 
	then
		EnableErr
	elif [ "$1" == "-d" ]
	then 
		DisableErr
	fi
	echo "${green} Exiting....${reset}"
	exit
}

# calling main function
main $1
