#!/bin/bash
source libraries/string.sh
source libraries/package.sh

ret_value=""

clear
echo "start …"

# custom list of the packages to install 
APT_GET_PACKAGES=("snapd" "snapd-xdg-open" "htop" "torbrowser-launcher" "git-all" "copyq" "filezilla" "ubuntu-cleaner" "inkscape" "peek" "notepadqq" "qbittorrent")
SNAP_PACKAGES=("chromium" "--classic code" "vlc" "whatsapp-app" "telegram-desktop" "skype" "youtube-music-desktop-app" "wps-office" "4ktube")

echo "starting to updating ..."
sudo add-apt-repository -y ppa:micahflee/ppa
sudo add-apt-repository -y ppa:gerardpuig/ppa
sudo add-apt-repository -y ppa:inkscape.dev/stable #inkscape
sudo add-apt-repository -y pps:peek-developers/stable #peek
sudo add-apt-repository -y ppa:notepadqq-team/notepadqq #notepad++
sudo add-apt-repository -y ppa:hluk/copyq #copyq
sudo apt-get -y update
echo "end updating!"

echo "starting to install apt-get applications …"
for pkg in ${APT_GET_PACKAGES[@]}
do
echo $pkg
is_package_exists="$(is_package_exists "$pkg")"
if [[ "$is_package_exists" == "1" ]]; then
  echo "Package $pkg already installed."
 else
     sudo apt-get install -y $pkg
 fi
done
echo "finished to install apt-get applications!"

echo "starting to install snap applications …"
for pkg in ${SNAP_PACKAGES[@]}
do
    #echo $pkg
    is_package_exists "$pkg"
    is_package_exists_ret=$ret_value
    
    echo "is_package_exists_ret="$is_package_exists_ret #debugger 

    if [[ $is_package_exists_ret == 0 ]]; then
        echo "Package $pkg already installed."
    else
        echo "start install snap"
        sudo snap install $pkg
    fi
done
echo "finished to install snap applications!"

echo “finished!”
