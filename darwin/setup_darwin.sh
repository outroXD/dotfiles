# -*- shell-script -*-

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew doctor

# common
brew install wget emacs

# wine
# https://bottoms-programming.com/archives/a5sql-mk-2-after-mac-catalina.html
brew install wine-stable xquartz
wget https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip
unzip NotoSansCJKjp-hinted.zip
mv *.otf ~/.wine/drive_c/windows/Fonts/
rm -f NotoSansCJKjp-hinted.zip LICENSE_OFL.txt
sudo emacs ~/.wine/user.reg
