# Debian / Ubuntu
sudo apt-get install --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake

git clone https://github.com/shadowsocks/simple-obfs.git
cd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure && make
sudo make install
