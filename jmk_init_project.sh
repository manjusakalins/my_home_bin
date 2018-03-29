
PROJ=$1

echo $PROJ
./makeJlink -a "make copy" -p $PROJ
source build/envsetup.sh
lunch full_$PROJ-eng
