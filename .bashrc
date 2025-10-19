clear

#update func
update(){
  echo -e "\n\e[1;97m [\e[1;93m*\e[1;97m] \e[1;93mUpdating and Upgrading packages\e[1;97m:\n"
  pkg update -y;pkg upgrade -y
  pkg autoclean -y && pkg clean -y
  apt autoremove -y
}


#welcome and next
welcome(){
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
}

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

neofetch

#custom-input
PS1='\n\[\e[92;1m\]┌─\[\e[0;91m\][\[\e[0m\]\T\[\e[91m\]]\[\e[92;1m\]─\[\e[0;91m\][\[\e[38;5;226m\]JS\[\e[91m\]]\[\e[92;1m\]──(\[\e[0m\]\#\[\e[92;1m\])\n└─\[\e[0;91m\][\[\e[96m\]\w\[\e[91m\]]\[\e[38;5;41;1m\]──\[\e[92m\]►\[\e[0m\] '


#aliases-and-func
alias ll='ls -alF'
alias ls='lsd'
alias r='termux-reload-settings'
alias lsa='ls -a'
cdl() {
  cd "$1" && lsa
}
rmd(){
  rm -r "$1" && lsa
}
alias c='clear'
alias b='. ~/.bashrc'
alias dx11='bash ~/debian_x11.sh'
alias d='proot-distro login --user js debian --bind /dev/null:/proc/sys/kernel/cap_last_last --shared-tmp --fix-low-ports'
alias nf='c;neofetch'
gcc() {
    if [ -z "$1" ]; then
        echo -e "\n\e[1;93mUsage: \e[1;92mgcc [filename.cpp] [output-filename] [input.txt]"
        return 1
    fi
    SRC="$1"
    if [ -z "$2" ]; then
    	OUT="output"
    else
    	OUT="$2"
    fi
    INP="$3"
    c
    clang++ -std=c++17 -O2 -pipe -s "$SRC" -o "$OUT" || return 1
    echo -e "\e[1;92mInput:\n\e[1;0m"
    cat "$INP"
    echo -e "\e\n\n[1;92mOutput:\n\e[1;0m"
	start=$(date +%s%N)
    if [ -n "$INP" ]; then
        ./"$OUT" < "$INP"
    else
        ./"$OUT"
    fi
    end=$(date +%s%N)
    runtime=$(echo "scale=3; ($end - $start)/1000000000" | bc -l)
    echo -e "\n\n-----------------------------"
    printf " |   Output in \e[38;5;226m%.3f\e[1;0m sec   |\n" "$runtime";
    echo "-----------------------------"
}
