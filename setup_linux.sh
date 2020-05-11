# -*- shell-script -*-

printf "enter your password: "
# shellcheck disable=SC2162
read password
current_dir=$(pwd)

echo "$password" | sudo -S pacman -S --noconfirm \
                           cmake \
                           zsh zsh-completions

# shellcheck disable=SC2034
ln -s "${current_dir}"/.zshrc ~/.zshrc
ln -s "${current_dir}"/.Xmodmap ~/.Xmodmap
ln -s "${current_dir}"/.xprofile ~/.xprofile
