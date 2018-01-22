#!/bin/bash
echo "This script will download and extract the selected GOODROM set to its corresponding directories in your rom folder."
CONFIG(){
	ROMDIR="~/RetroPie/roms"
	WORKDIR="~/RetroPie-Goodrom-Full-Romsets"
	DLDIR=~/RetroPie-Goodrom-Full-Romsets/Romsets
	MENUDIR="/opt/retropie/configs/goodromdl"
	THEMEDIR="/opt/retropie/configs/all/emulationstation/themes/carbon-custom"
	echo "Romdir is set to: " $ROMDIR
	echo "Workdir is set to: " $WORKDIR
	echo "Menudir is set to: " $MENUDIR
	echo "Themedir is set to: " $THEMEDIR
	echo "Sets wil be downloaded to :" $DLDIR
	echo "Once downloaded they will be extracted and the files wil be copied to their respective romdir"
	read -rsp $'Press [ENTER] to continue...\n'
	clear
	}
MENU(){
	if [ -d "$MENUDIR" ]; then
	echo "$MENUDIR allready exists! skipping..."
	read -rsp $'Press [ENTER] to continue...\n'
	clear
	else
	echo "Setting up emulationstation menu"
	mkdir $MENUDIR
	cp ~/RetroPie-Goodrom-Full-Romsets/Menu/es_systems.cfg $MENUDIR/es_systems.cfg
	cp ~/RetroPie-Goodrom-Full-Romsets/Menu/emulators.cfg $MENUDIR/emulators.cfg
	echo "Please edit your /opt/retropie/configs/all/emulationstation/es_systems.cfg"
	echo "So that it includes the contents of Menu/es_systems.cfg (Copy lines below):"
	cat ~/RetroPie-Goodrom-Full-Romsets/Menu/es_systems.cfg
	read -rsp $'Press [ENTER] to continue...\n'
	nano /opt/retropie/configs/all/emulationstation/es_systems.cfg
	echo "If all went well there should now be a menu item in emulationstation."
	read -rsp $'Press [ENTER] to continue...\n'
	clear
	fi
	}
THEME(){
	if [ -d "$THEMEDIR/goodromdl" ]; then
	echo "$THEMEDIR/goodromdl allready exists! skipping..."
	read -rsp $'Press [ENTER] to continue...\n'
	clear
	else
	echo "Setting up emulationstation theme"
	cp /etc/emulationstation/themes/carbon $THEMEDIR
	mkdir $THEMEDIR/goodromdl
	cp ~/RetroPie-Goodrom-Full-Romsets/Menu/es_systems.cfg /opt/retropie/configs/goodromdl/es_systems.cfg
	cp ~/RetroPie-Goodrom-Full-Romsets/Menu/emulators.cfg /opt/retropie/configs/goodromdl/emulators.cfg
	echo "A theme has been set up in: " $THEMEDIR
	echo "Select it in emulationstation to use it."
	read -rsp $'Press [ENTER] to continue...\n'
	clear
	fi
	}

DOWNLOADING(){
	DLTORRENT(){
	URL="https://ipfs.io/ipfs/QmdUU&&&Qqoqu1M7DDkBuXar5A33ZSuSbBEsCCvCBYzvzow/No-Intro-Collecton_2016-01-03_Fixed"
	TORRENT="$URL/No-Intro-Collection_2016-01-03_Fixed.torrent"
	echo "Downloading though torrent from: " $TORRENT
	read -rp $'Use [T]ransmission, [R]torrent or [D]eluge: ' -ei $'T' OPTION;
	if [ $OPTION = "T" ]; then
	echo "You chose [T]ransmission; " $OPTION
	sudo apt-get install transmission-cli
	transmission-cli $TORRENT
	fi
	if [ $OPTION = "R" ]; then
	echo "You chose [R]torrent; " $OPTION
	sudo apt-get install rtorrent
	rtorrent $TORRENT
	fi
	if [ $OPTION = "D" ]; then
	echo "You chose [D]eluge; " $OPTION
	sudo apt-get install deluge
	deluge $TORRENT
	fi
	}
	DLHTTPS(){
	URL="https://ipfs.io/ipfs/QmdUU&&&Qqoqu1M7DDkBuXar5A33ZSuSbBEsCCvCBYzvzow/No-Intro-Collecton_2016-01-03_Fixed"
	read -rp $'Download [A]ll or [I]ndividual files: ' -ei $'A' OPTION;
	if [ $OPTION = "A" ]; then
	echo "You chose to download [A]ll: " $OPTION
	cd $DLDIR
	wget -r -np -R "ïndex.html*" $URL
	read -rsp $'Press [ENTER] to continue...\n'
	fi
	if [ $OPTION = "I" ]; then
	echo "You chose to download [I]ndividual: " $OPTION
	cd $DLDIR
	read -rsp $'Press [ENTER] to continue...\n'
	fi






	}

read -rp $'Full [T]orrent or individual file through [H]ttps : ' -ei $'H' OPTION;
if [ $OPTION = "T" ]; then
echo "You chose to download Full [T]orrent: " $OPTION
DLTORRENT
fi
if [ $OPTION = "H" ]; then
echo "You chose to download individual file through [H]ttps: " $OPTION
DLHTTPS
fi


}
## EXEC ##
CONFIG
MENU
THEME
DOWNLOADING
