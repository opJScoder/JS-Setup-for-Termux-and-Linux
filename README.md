
Copy the commands, run in termux, enter if stopped! It will auto close or enter to close, then start a new session!
```sh
termux-setup-storage
termux-change-repo
clear
echo -e "\n\e[1;97m [\e[1;93m*\e[1;97m] \e[1;93mUpdating and Upgrading packages\e[1;97m:\n"
pkg update -y;pkg upgrade -y
pkg autoclean -y && pkg clean -y
apt autoremove -y
pkg i wget lsd neofetch -y
neofetch
wget https://raw.githubusercontent.com/opJScoder/JS-Setup-for-Termux-and-Linux/refs/heads/main/.bashrc
echo 'font = "fonts/Hack Nerd Font Complete.ttf"' >> .termux/termux.properties
wget https://github.com/opJScoder/JS-Setup-for-Termux-and-Linux/raw/refs/heads/main/font.ttf
mv font.ttf .termux
wget https://github.com/opJScoder/JS-Setup-for-Termux-and-Linux/raw/refs/heads/main/Debian/Neofetch/config.conf
mv config.conf .config/neofetch/
exit
```

For C++ Compiler!
```sh
pkg i clang bc -y
c;g++ --version
```

To compile and run the program(mine):
```sh
gcc "storage/shared/My Assets/Coding/C++/main.cpp" main "storage/shared/My Assets/Coding/C++/input.txt"
```

gcc usage: gcc [filename.cpp]  [output-filename]  [input.txt]

Other aliases:
- c - clear screen
- b - refresh .bashrc file
- ls - lsd
- lsa - ls -a
- ll - ls -alF
- cdl $1 - cd $1 && lsa
- rmd $1 - rm -r $1 && lsa
- nf - c;neofetch
- update - Update and upgrade all packages
