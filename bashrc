# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
export PATH=~/all_codes/my_codes/myqq_python/dev_tools/depot_tools:~/bin:~/bin/images:~/bin/SignTool:$PATH
#export PATH=/home/manjusaka/all_codes/mtk6572/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.6/bin:$PATH
export PATH=/usr/lib/arm-linux-androideabi-4.6/prebuilt/linux-x86_64/bin:$PATH
export USE_CCACHE=1
#export CCACHE_COMPILERCHECK=content
#export CCACHE_SLOPPINESS=time_macros,include_file_mtime,file_macro
export CCACHE_DIR=/media/2Tdata/for_ccache_dir
export CCACHE_LOGFILE=/media/2Tdata/for_ccache_dir/ccache.logss
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
#alias kinc='cd /data/build/kernel_l27x/omap;make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- -j4 uImage;cp arch/arm/boot/zImage /data/data/emmc/zImage;cd /data/data/emmc;  ./umulti.sh; ls -l;sudo ./fastboot flash boot boot.img'
#alias mkinc='cd /home/manjusaka/all_codes/mtk_codes/exocet_jb_6577; ./makeMtk  r k; out/host/linux-x86/bin/mkbootimg  --kernel kernel/out/kernel_jrdsh77_cu_jb.bin --ramdisk out/target/product/jrdsh77_cu_jb/ramdisk.img --board vS21-0 --output out/target/product/jrdsh77_cu_jb/boot.img'
alias mlog='adb logcat | /home/manjusaka/bin/coloredlogcat.py'
alias radiolog='adb logcat -b radio | /home/manjusaka/bin/coloredlogcat.py'
#alias cpwd='pwd | xsel'
alias mkmtkboot='bash ~/bin/mk_boot.sh'
alias mkkmtkboot='bash ~/bin/mk_bootkk.sh'
alias reposync='repo forall -c git checkout -f;repo forall -c git checout master ;repo sync -j16 -f;'
#alias cpwd='pwd | xsel'
alias mkmtkboot='bash ~/bin/mk_boot.sh'
alias mkkmtkboot='bash ~/bin/mk_bootkk.sh'
alias mdmake='bash ~/bin/modemmake.sh'
export GREP_OPTIONS='--color=auto'
alias mkfastflash='bash ~/bin/flash_fast.sh'
alias gitadd='bash ~/bin/gitaddm.sh'
#alias ggat='/home/manjusaka/work_data/oold/debug/gat-linux-x86_64-3.0/gat'
#alias ggat='//media/newdata/mtk_toolss/GAT_v3.1633.2/GAT_exe_v3.1633.2/gat-linux-x86_64-3/gat'
alias ggat='/media/newdata/mtk_toolss/GAT_v3.1716.3/GAT_exe_v3.1716.3/gat-linux-x86_64-3/gat'
alias appins='bash ~/bin/appinstall.sh'
alias reposync='repo forall -c git checkout -f; repo sync -j8 -f;'
alias myfgrep='echo "find . \( -path ".*/.*" -o -path "*/out" \) -prune -o -type f -print | xargs grep"; find . \( -path ".*/.*" -o -path "*/out" \) -prune -o -type f -print | xargs grep '
alias mlpl='PROJ=$(echo $TARGET_PRODUCT | sed 's/full_//g');CURDIRLL=$(pwd);cd bootable/bootloader/preloader;TARGET_PRODUCT=$PROJ ./build.sh 2>&1;cd -;cp $CURDIRLL/out/target/product/$PROJ/obj/PRELOADER_OBJ/bin/preloader_$PROJ.bin $CURDIRLL/out/target/product/$PROJ/'
alias mllk='PROJ=$(echo $TARGET_PRODUCT | sed 's/full_//g');CURDIRLL=$(pwd);cd bootable/bootloader/lk;make -j24 $PROJ;cp ./build-$PROJ/lk.bin $CURDIRLL/out/target/product/$PROJ/;cd -'
alias myfgrep='echo "find . \( -path ".*/.*" -o -path "*/out" \) -prune -o -type f -print | xargs grep"; find . \( -path ".*/.*" -o -path "*/out" \) -prune -o -type f -print | xargs grep -n'
#alias mlkk='PROJ=$(echo $TARGET_PRODUCT | sed 's/full_//g');CURDIRLL=$(pwd);make -j16 -C kernel-3.10 O=$CURDIRLL/kernel-3.10/OUT_${PROJ}/ ARCH=arm64 CROSS_COMPILE="ccache $CURDIRLL/prebuilts/gcc/linux-x86/aarch64/cit-aarch64-linux-android-4.9/bin/aarch64-linux-android-" ROOTDIR=$CURDIRLL;cp $CURDIRLL/kernel-3.10/OUT_${PROJ}/arch/arm64/boot/Image.gz-dtb  $CURDIRLL/out/target/product/$PROJ/kernel;make ramdisk-nodeps; make bootimage-nodeps'
stty -ixon
alias mmmdcopy='bash ~/bin/modem_copy.sh'
alias mlmdcopy='perl /home/manjusaka/all_codes/6735l1/device/mediatek/build/build/tools/modemRenameCopy.pl $(pwd)'
alias mlcmdcopy='perl /home/manjusaka/all_codes/m06735/device/mediatek/build/build/tools/modemRenameCopy.pl $(pwd)'
alias ml8mdcopy='perl /home/manjusaka/all_codes/ll80/device/mediatek/build/build/tools/modemRenameCopy.pl $(pwd)'
#alias mlcf='PROJ=$(echo $TARGET_PRODUCT | sed 's/full_//g');CURDIRLL=$(pwd);mkdir kernel-3.10/OUT_$PROJ;cd kernel-3.10;make O=OUT_${PROJ} ${PROJ}_debug_defconfig ARCH=arm64;cd -'

#alias ml8cf='PROJ=$(echo $TARGET_PRODUCT | sed 's/full_//g');CURDIRLL=$(pwd);mkdir kernel-3.10/OUT_$PROJ;cd kernel-3.10;make O=OUT_${PROJ} ${PROJ}_debug_defconfig ARCH=arm;cd -'
#alias ml8kk='PROJ=$(echo $TARGET_PRODUCT | sed 's/full_//g');CURDIRLL=$(pwd);make -j16 -C kernel-3.10 O=$CURDIRLL/kernel-3.10/OUT_${PROJ}/ ARCH=arm CROSS_COMPILE="ccache $CURDIRLL/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/arm-eabi-" ROOTDIR=$CURDIRLL;cp $CURDIRLL/kernel-3.10/OUT_${PROJ}/arch/arm/boot/zImage-dtb  $CURDIRLL/out/target/product/$PROJ/kernel;make ramdisk-nodeps; make bootimage-nodeps'

alias mlkk='bash ~/bin/mk_l1_kernel.sh'
alias mykill='bash ~/bin/kill_dev_bin.sh'
alias myadbp='bash ~/bin/myadbpushall.sh'
alias mlmddircopy='bash ~/bin/for_modem/auto_copy_temp_modem_to_system_dir.sh'
alias mmpl='bash ~/bin/mm_make.sh pl'
alias mmlk='bash ~/bin/mm_make.sh lk'
alias mmkk='bash ~/bin/mm_make.sh kk'
alias mmkcf='bash ~/bin/mm_make.sh kconfig'
alias mymdpush='bash ~/bin/modem_push.sh'
alias mymdprocopy='bash ~/bin/md_copy_pro.sh'
alias mmsp='bash ~/bin/mm_sprd_l1.sh'
alias mlmdmake='bash ~/bin/modem_copy.sh'

alias mtkflash1648='cd /media/newdata/all_new_code/flash_tool/1648_Output/linux/debug/; sudo ./flash_tool'
alias mtkoldflash1540='cd /media/newdata/all_new_code/flash_tool/SP_Flash_Tool_src_5.1540.00.000/_Output/linux/debug/; sudo ./flash_tool'
alias batpull='sh ~/bin/battery_pull.sh'
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/
#alias jmkc='./makeJlink -a "make copy" -p '
#alias jmk='. ~/bin/jmk_init_project.sh'
