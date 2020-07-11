# -*- shell-script -*-

printf "enter your password: "
# shellcheck disable=SC2162
read password
# shellcheck disable=SC2164
home=$(cd ~/ && pwd)

printf "update & upgrade apps."
echo "$password" | \
sudo apt -y update && \
sudo apt -y upgrade

printf "install common apps."
echo "$password" | \
sudo apt -y install dkms

printf "create & move to working dir."
mkdir tmp && cd tmp || exit

printf "download resource files from github."
mkdir github && cd github || exit
git clone https://github.com/outroXD/dotfiles && cd dotfiles || exit
# shellcheck disable=SC2034
ln -s "${home}"/.zshrc ~/.zshrc
ln -s "${home}"/.Xmodmap ~/.Xmodmap
ln -s "${home}"/.xprofile ~/.xprofile
cd ../../ || exit

printf "keyboard settings."
echo "$password" | \
apt -y install fcitx fcitx-mozc | \
sudo dpkg-reconfigure keyboard-configuration

printf "ssh settings."
cd /etc/ssh || exit
echo "$password" | \
sudo sed -i.bk 's/#Port 22/Port 50022/g' sshd_config && \
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' sshd_config && \
sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' sshd_config && \
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' sshd_config
echo "$password" | \
sudo systemctl restart sshd && \
sudo systemctl status sshd

printf "iptables settings."
echo "$password" | \
sudo apt -y install iptables-persistent

printf "install gpu driver."
mkdir gpu && cd gpu || exit
wget http://jp.download.nvidia.com/XFree86/Linux-x86_64/450.57/NVIDIA-Linux-x86_64-450.57.run || exit
sudo bash ./NVIDIA-Linux-x86_64-450.57.run --no-opengl-files --no-libglx-indirect --dkms
cd ../

printf "clean up."
cd home && rm -rf tmp || exit
