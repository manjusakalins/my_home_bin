cd /home/manjusaka/4Tdata/my_codes/in_github
git clone https://github.com/manjusakalins/my_home_bin.git
git clone https://github.com/manjusakalins/jl_fl_1648.git
git clone https://github.com/manjusakalins/myvim.git
git clone https://github.com/manjusakalins/sessionman.vim.git
git clone https://github.com/manjusakalins/TabBar.git
git clone https://github.com/manjusakalins/spf13-vim.git

ls | awk '{system("cd "$1"; git pull;cd -")}'
