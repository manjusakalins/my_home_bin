DEST_DIR_SYSTEM=$1

echo $(pwd)
CUR_TOP_DIR=$(pwd)
cp $CUR_TOP_DIR/temp_modem/catcher_filter_1_lwg_n.bin $DEST_DIR_SYSTEM/etc/firmware/
cp $CUR_TOP_DIR/temp_modem/catcher_filter_1_ltg_n.bin $DEST_DIR_SYSTEM/etc/firmware/

cp $CUR_TOP_DIR/temp_modem/dsp_1_lwg_n.bin $DEST_DIR_SYSTEM/etc/firmware/
cp $CUR_TOP_DIR/temp_modem/dsp_1_ltg_n.bin $DEST_DIR_SYSTEM/etc/firmware/

cp $CUR_TOP_DIR/temp_modem/modem_1_lwg_n.img $DEST_DIR_SYSTEM/etc/firmware/
cp $CUR_TOP_DIR/temp_modem/modem_1_ltg_n.img $DEST_DIR_SYSTEM/etc/firmware/


#copy db
rm -rf  $DEST_DIR_SYSTEM/etc/mddb
mkdir  $DEST_DIR_SYSTEM/etc/mddb
dbi=$(ls $CUR_TOP_DIR/temp_modem/ | grep DbgInfo)
echo $dbi
cp $CUR_TOP_DIR/temp_modem/$dbi $DEST_DIR_SYSTEM/etc/mddb
BPL=$(ls $CUR_TOP_DIR/temp_modem/ | grep BPLGUInfo)
echo $BPL
cp $CUR_TOP_DIR/temp_modem/$BPL $DEST_DIR_SYSTEM/etc/mddb


