#!/bin/bash

# ──────────────────────────────────────────────
# JS’s Clean Ubuntu GUI Installer (No VNC)
# ──────────────────────────────────────────────

R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
W="$(printf '\033[1;37m')"
C="$(printf '\033[1;36m')"
arch=$(uname -m)
username=$(getent group sudo | awk -F ':' '{print $4}' | cut -d ',' -f1)

check_root() {
	if [ "$(id -u)" -ne 0 ]; then
		echo -ne " ${R}Run this program as root!\n\n${W}"
		exit 1
	fi
}

banner() {
	clear
	cat <<- EOF
		${Y}    _  _ ___  _  _ _  _ ___ _  _    _  _ ____ ___  
		${C}    |  | |__] |  | |\ |  |  |  |    |\/| |  | |  \ 
		${G}    |__| |__] |__| | \|  |  |__|    |  | |__| |__/ 

	EOF
	echo -e "${G}     A modded GUI version of Ubuntu for Termux\n"
}

note() {
	banner
	echo -e " ${G}[-] Successfully Installed!${W}\n"
	sleep 1
	cat <<- EOF
	${C}Your XFCE Desktop Environment is ready.${W}

	${Y}To start your graphical session:${W}
	  - If using Termux:X11 → launch it and run: ${C}startxfce4${W}
	  - If on Linux or WSL → start an X server and run: ${C}startxfce4${W}

	${G}Enjoy your lightweight Ubuntu desktop!${W}
	EOF
}

package() {
	banner
	echo -e "${R}[${W}-${R}]${C} Checking required packages...${W}"
	apt-get update -y
	apt install udisks2 -y
	rm /var/lib/dpkg/info/udisks2.postinst 2>/dev/null
	echo "" > /var/lib/dpkg/info/udisks2.postinst
	dpkg --configure -a
	apt-mark hold udisks2
	
	packs=(sudo gnupg2 curl nano git xz-utils at-spi2-core xfce4 xfce4-goodies xfce4-terminal librsvg2-common menu inetutils-tools dialog exo-utils dbus-x11 fonts-beng fonts-beng-extra gtk2-engines-murrine gtk2-engines-pixbuf apt-transport-https)
	for pkg in "${packs[@]}"; do
		if ! command -v "$pkg" &>/dev/null; then
			echo -e "\n${R}[${W}-${R}]${G} Installing package: ${Y}$pkg${W}"
			apt-get install "$pkg" -y --no-install-recommends
		fi
	done
	
	apt-get update -y
	apt-get upgrade -y
}

install_apt() {
	for app in "$@"; do
		if command -v "$app" &>/dev/null; then
			echo "${Y}${app} is already installed!${W}"
		else
			echo -e "${G}Installing ${Y}${app}${W}"
			apt install -y "$app"
		fi
	done
}

install_vscode() {
	if command -v code &>/dev/null; then
		echo "${Y}VSCode is already installed!${W}"
	else
		echo -e "${G}Installing ${Y}VSCode${W}"
		curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
		install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
		echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
		apt update -y
		apt install code -y
		curl -fsSL https://raw.githubusercontent.com/modded-ubuntu/modded-ubuntu/master/patches/code.desktop > /usr/share/applications/code.desktop
		echo -e "${C}Visual Studio Code installed successfully.${W}\n"
	fi
}

install_sublime() {
	if command -v subl &>/dev/null; then
		echo "${Y}Sublime is already installed!${W}"
	else
		apt install gnupg2 software-properties-common --no-install-recommends -y
		echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
		curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor > /etc/apt/trusted.gpg.d/sublime.gpg 2>/dev/null
		apt update -y
		apt install sublime-text -y 
		echo -e "${C}Sublime Text Editor installed successfully.${W}\n"
	fi
}

install_chromium() {
	if command -v chromium &>/dev/null; then
		echo "${Y}Chromium is already installed!${W}\n"
	else
		echo -e "${G}Installing ${Y}Chromium${W}"
		apt purge chromium* chromium-browser* snapd -y
		apt install gnupg2 software-properties-common --no-install-recommends -y
		echo -e "deb http://ftp.debian.org/debian buster main\ndeb http://ftp.debian.org/debian buster-updates main" >> /etc/apt/sources.list
		apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DCC9EFBF77E11517 648ACFD622F3D138 AA8E81B4331F7F50 112695A0E562B32A 3B4FE6ACC0B21F32
		apt update -y
		apt install chromium -y
		sed -i 's/chromium %U/chromium --no-sandbox %U/g' /usr/share/applications/chromium.desktop
		echo -e "${G}Chromium installed successfully.${W}\n"
	fi
}

install_firefox() {
	if command -v firefox &>/dev/null; then
		echo "${Y}Firefox is already installed!${W}\n"
	else
		echo -e "${G}Installing ${Y}Firefox${W}"
		bash <(curl -fsSL "https://raw.githubusercontent.com/modded-ubuntu/modded-ubuntu/master/distro/firefox.sh")
		echo -e "${G}Firefox installed successfully.${W}\n"
	fi
}

install_softwares() {
	banner
	cat <<- EOF
		${Y}---${G} Select Browser ${Y}---

		${C}[${W}1${C}] Firefox (Default)
		${C}[${W}2${C}] Chromium
		${C}[${W}3${C}] Both (Firefox + Chromium)
	EOF
	read -n1 -p "${R}[${G}~${R}]${Y} Select an option: ${G}" BROWSER_OPTION
	banner

	[[ ("$arch" != 'armhf') || ("$arch" != *'armv7'*) ]] && {
		cat <<- EOF
			${Y}---${G} Select IDE ${Y}---

			${C}[${W}1${C}] Sublime Text Editor (Recommended)
			${C}[${W}2${C}] Visual Studio Code
			${C}[${W}3${C}] Both (Sublime + VSCode)
			${C}[${W}4${C}] Skip! (Default)
		EOF
		read -n1 -p "${R}[${G}~${R}]${Y} Select an option: ${G}" IDE_OPTION
		banner
	}
	
	cat <<- EOF
		${Y}---${G} Media Player ${Y}---

		${C}[${W}1${C}] MPV Media Player (Recommended)
		${C}[${W}2${C}] VLC Media Player
		${C}[${W}3${C}] Both (MPV + VLC)
		${C}[${W}4${C}] Skip! (Default)
	EOF
	read -n1 -p "${R}[${G}~${R}]${Y} Select an option: ${G}" PLAYER_OPTION
	banner

	# Browser installation
	case ${BROWSER_OPTION} in
		2) install_chromium ;;
		3) install_firefox; install_chromium ;;
		*) install_firefox ;;
	esac

	# IDE installation
	if [[ ("$arch" != 'armhf') || ("$arch" != *'armv7'*) ]]; then
		case ${IDE_OPTION} in
			1) install_sublime ;;
			2) install_vscode ;;
			3) install_sublime; install_vscode ;;
			*) echo -e "${Y}[!] Skipping IDE installation${W}\n"; sleep 1 ;;
		esac
	fi

	# Media player installation
	case ${PLAYER_OPTION} in
		1) install_apt "mpv" ;;
		2) install_apt "vlc" ;;
		3) install_apt "mpv" "vlc" ;;
		*) echo -e "${Y}[!] Skipping media player installation${W}\n"; sleep 1 ;;
	esac
}

downloader() {
	path="$1"
	[[ -e "$path" ]] && rm -rf "$path"
	echo "Downloading $(basename "$path")..."
	curl --progress-bar --insecure --fail \
		--retry-connrefused --retry 3 --retry-delay 2 \
		--location --output "$path" "$2"
}

rem_theme() {
	theme=(Bright Daloa Emacs Moheli Retro Smoke)
	for rmi in "${theme[@]}"; do
		rm -rf "/usr/share/themes/$rmi" 2>/dev/null
	done
}

rem_icon() {
	fonts=(hicolor LoginIcons ubuntu-mono-light)
	for rmf in "${fonts[@]}"; do
		rm -rf "/usr/share/icons/$rmf" 2>/dev/null
	done
}

config() {
	banner
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
	yes | apt upgrade
	yes | apt install gtk2-engines-murrine gtk2-engines-pixbuf sassc optipng inkscape libglib2.0-dev-bin

	mv -vf /usr/share/backgrounds/xfce/xfce-verticals.png /usr/share/backgrounds/xfce/xfceverticals-old.png 2>/dev/null
	temp_folder=$(mktemp -d -p "$HOME")
	cd "$temp_folder" || exit 1

	echo -e "${R}[${W}-${R}]${C} Downloading required files...${W}\n"
	downloader "fonts.tar.gz" "https://github.com/modded-ubuntu/modded-ubuntu/releases/download/config/fonts.tar.gz"
	downloader "icons.tar.gz" "https://github.com/modded-ubuntu/modded-ubuntu/releases/download/config/icons.tar.gz"
	downloader "wallpaper.tar.gz" "https://github.com/modded-ubuntu/modded-ubuntu/releases/download/config/wallpaper.tar.gz"
	downloader "gtk-themes.tar.gz" "https://github.com/modded-ubuntu/modded-ubuntu/releases/download/config/gtk-themes.tar.gz"
	downloader "ubuntu-settings.tar.gz" "https://github.com/modded-ubuntu/modded-ubuntu/releases/download/config/ubuntu-settings.tar.gz"

	echo -e "${R}[${W}-${R}]${C} Unpacking files...${W}\n"
	tar -xvzf fonts.tar.gz -C "/usr/local/share/fonts/"
	tar -xvzf icons.tar.gz -C "/usr/share/icons/"
	tar -xvzf wallpaper.tar.gz -C "/usr/share/backgrounds/xfce/"
	tar -xvzf gtk-themes.tar.gz -C "/usr/share/themes/"
	tar -xvzf ubuntu-settings.tar.gz -C "/home/$username/"	
	rm -rf "$temp_folder"

	echo -e "${R}[${W}-${R}]${C} Cleaning unnecessary files...${W}"
	rem_theme
	rem_icon

	echo -e "${R}[${W}-${R}]${C} Rebuilding font cache...${W}\n"
	fc-cache -fv

	echo -e "${R}[${W}-${R}]${C} Final system upgrade...${W}\n"
	apt update
	yes | apt upgrade
	apt clean
	yes | apt autoremove
}

# ───────────────────────────────
check_root
package
install_softwares
config
note
# ───────────────────────────────