find -L `pwd` -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.h' -o -name '*.mk' > cscope.files
cscope -Rbkq cscope.files
#ctags -R --exclude=.git
#need call cscope
echo "please call cscope"
echo "ctags -R --exclude=.git"


