(echo "Y") | sudo add-apt-repository ppa:openjdk-r/ppa
(echo "Y") | sudo apt-get update
(echo "Y") | sudo apt-get install openjdk-7-jdk
#(echo "Y") | sudo apt-get install nautilus-open-terminal
(echo "Y") |sudo add-apt-repository ppa:ubuntu-wine/ppa
(echo "Y") |sudo apt-get update
#(echo "Y") |sudo apt-get install wine1.8
sudo apt-get install wine1.8
cd ~/
#curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh
#https://github.com/spf13/spf13-vim
#update 
#curl https://j.mp/spf13-vim3 -L -o - | sh



#down load dir change
#修改$HOME/.config/user-dirs.dirs这个文件

cd ~/4Tdata/new_pc_setup/jdk_16_env
chmod 777 *
sudo cp jdk-6u37-linux-x64.bin /opt/
cd /opt/
sudo chmod 777 jdk-6u37-linux-x64.bin
sudo ./jdk-6u37-linux-x64.bin
cd -
sudo ./javacfg.sh
