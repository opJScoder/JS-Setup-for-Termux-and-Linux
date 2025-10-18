clear


#update func
update(){
  echo -e "\n\e[1;97m [\e[1;93m*\e[1;97m] \e[1;93mUpdating and Upgrading packages\e[1;97m:\n"
  pkg update -y;pkg upgrade -y
  pkg autoclean -y && pkg clean -y
  apt autoremove -y
}


#welcome and next
echo -e "\n"
echo -e "\e[1;97m<\e[1;32m==================================\e[1;97m>"
echo -e "  \e[1;97m‡\e[1;91m★\e[1;97m‡  \e[1;93m Welcome to \e[1;96mJS\e[1;97m-\e[1;96mTermux  \e[1;97m‡\e[1;91m★\e[1;97m‡"
echo -e "\e[1;97m<\e[1;32m==================================\e[1;97m>"
echo -ne "\n\e[1;93mWant to update and upgrade Termux? (y/n): [Enter to start pd] "
read a
case $a in
  y) update ;;
  n) : ;;
  *) dx11 ;;
  esac


#continued-art-on-startup
clear
echo -e "\e[1;32m\n"
echo ' _____                                                                      _____
( ___ )                                                                    ( ___ )
 |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   |
 |   |                                                                      |   |
 |   |                                                                      |   |
 |   |   _    _  _____  _      _____  _____ ___  ___ _____   _____  _____   |   |
 |   |  | |  | ||  ___|| |    /  __ \|  _  ||  \/  ||  ___| |_   _||  _  |  |   |
 |   |  | |  | || |__  | |    | /  \/| | | || .  . || |__     | |  | | | |  |   |
 |   |  | |/\| ||  __| | |    | |    | | | || |\/| ||  __|    | |  | | | |  |   |
 |   |  \  /\  /| |___ | |____| \__/\\ \_/ /| |  | || |___    | |  \ \_/ /  |   |
 |   |   \/  \/ \____/ \_____/ \____/ \___/ \_|  |_/\____/    \_/   \___/   |   |
 |   |      ___  _____        _____  _____ ______ ___  ___ _   _ __   __    |   |
 |   |     |_  |/  ___|      |_   _||  ___|| ___ \|  \/  || | | |\ \ / /    |   |
 |   |       | |\ `--.  ______ | |  | |__  | |_/ /| .  . || | | | \ V /     |   |
 |   |       | | `--. \|______|| |  |  __| |    / | |\/| || | | | /   \     |   |
 |   |   /\__/ //\__/ /        | |  | |___ | |\ \ | |  | || |_| |/ /^\ \    |   |
 |   |   \____/ \____/         \_/  \____/ \_| \_|\_|  |_/ \___/ \/   \/    |   |
 |   |                                                                      |   |
 |   |                                                                      |   |
 |   |                                                                      |   |
 |   |                                                                      |   |
 |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___|
(_____)                                                                    (_____)'
echo ''


#custom-input
PS1='\n\[\e[92;1m\]┌─\[\e[0;91m\][\[\e[0m\]\T\[\e[91m\]]\[\e[92;1m\]─\[\e[0;91m\][\[\e[38;5;226m\]JS\[\e[91m\]]\[\e[92;1m\]──(\[\e[0m\]\#\[\e[92;1m\])\n└─\[\e[0;91m\][\[\e[96m\]\w\[\e[91m\]]\[\e[38;5;41;1m\]──\[\e[92m\]►\[\e[0m\] '


#aliases-and-func
alias ls='lsd'
alias r='termux-reload-settings'
alias lsa='lsd -a'
cdl() {
  cd "$1" && lsa
}
alias s='source ~/.bashrc'
rmd(){
  rm -r "$1" && lsa
}
alias c='clear'
alias b='. ~/.bashrc'
alias dx11='bash ~/debian_x11.sh'
alias d='proot-distro login --user js debian --bind /dev/null:/proc/sys/kernel/cap_last_last --shared-tmp --fix-low-ports'
