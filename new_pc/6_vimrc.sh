mkdir -p ~/4Tdata/vim_stuff/vimswap
mkdir -p ~/4Tdata/vim_stuff/vimundo
mkdir -p ~/4Tdata/vim_stuff/vimbackup
mkdir -p ~/4Tdata/vim_stuff/vimviews
mkdir -p ~/4Tdata/vim_stuff/sessions
mkdir -p ~/4Tdata/vim_stuff/viminfos
mkdir -p ~/4Tdata/vim_stuff/bundle


rm -rf ~/.vim/bundle
ln -s ~/4Tdata/vim_stuff/bundle ~/.vim/bundle

rm -rf ~/.vimswap ~/.vimundo ~/.vimviews ~/.vimbackup
ln -s ~/4Tdata/vim_stuff/sessions ~/.vim/sessions
ln -s ~/4Tdata/vim_stuff/viminfos ~/.vim/viminfos
ln -s ~/4Tdata/vim_stuff/vimswap ~/.vimswap
ln -s ~/4Tdata/vim_stuff/vimundo ~/.vimundo
ln -s ~/4Tdata/vim_stuff/vimbackup ~/.vimbackup
ln -s ~/4Tdata/vim_stuff/vimviews ~/.vimviews

rm -rf ~/.vimrc.bundles.local ~/.vimrc.before.local ~/.vimrc.local
ln -s ~/4Tdata/my_codes/in_github/myvim/spf13/vimrc.before.local ~/.vimrc.before.local
ln -s ~/4Tdata/my_codes/in_github/myvim/spf13/vimrc.bundles.local ~/.vimrc.bundles.local
ln -s ~/4Tdata/my_codes/in_github/myvim/spf13/vimrc.local ~/.vimrc.local

rm -rf ~/bin
ln -s ~/4Tdata/my_codes/in_github/my_home_bin ~/bin
ln -s ~/bin/.kermrc ~/.kermrc
ln -s ~/bin/sprdrc ~/sprdrc
ln -s ~/bin/bashrc ~/.bashrc
mkdir -p ~/.android
ln -s ~/4Tdata/my_codes/in_github/my_home_bin/usb_adb.ini ~/.android/usb_adb.ini

cd ~/4Tdata/my_codes/in_github/spf13-vim/
sh spf13-vim.sh
#vim +BundleInstall! +BundleClean +q

