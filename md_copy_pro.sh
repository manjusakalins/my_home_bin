
echo "run sample: ./xx CUSTOM S960_USA"


dirlist='el1_rf/MT6735_LTE_MT6169_ l1_rf/MT6735_2G_MT6169_ mml1_rf/MT6735_MMRF_ tl1_rf/MT6735_MT6169_UMTS_TDD_ ul1_rf/MT6735_UMTS_FDD_MT6169_'
custom_dir="custom/modem"
root_dir=$(pwd)
source_name=$1
dest_name=$2
for ldir in $dirlist
do
	echo $ldir
	cur_dir=$root_dir/$custom_dir/$ldir
	echo $cur_dir$source_name
	cp -rf $cur_dir$source_name $cur_dir$dest_name
done

### add to make/Option.mak
echo "COM_DEFS_FOR_MT6735_LTE_MT6169_CUSTOM = MT6169_RF MT6169_LTE_RF MT6735_LTE_MT6169_CUSTOM
COM_DEFS_FOR_MT6735_2G_MT6169_CUSTOM  = MT6169_2G_RF MT6735_2G_MT6169_CUSTOM
COM_DEFS_FOR_MT6735_MT6169_UMTS_TDD_CUSTOM = MT6169_RF MT6169_UMTS_TDD MT6735_MT6169_UMTS_TDD_CUSTOM
COM_DEFS_FOR_MT6735_UMTS_FDD_MT6169_CUSTOM = MT6169_RF MT6169_UMTS_FDD MT6735_UMTS_FDD_MT6169_CUSTOM" | sed 's/CUSTOM/'$dest_name'/g' >> make/Option.mak



function sed_replace()
{
    echo $1 $2 $3
    cat  $1 | sed 's/'$2'/'$3'/g' > re_tmp;
    mv re_tmp $1;
}

if [[ $source_name == "CUSTOM" ]]
then
#THE orignal source files
LWG_SOURCE_MAK="make/JHZ6735M_65C_VF_L(LWG_DSDS).mak"
LWG_SOURCE_EXT_MAK="make/custom_config/JHZ6735M_65C_VF_L(LWG_DSDS)_EXT.mak"
LTTG_SOURCE_MAK="make/JHZ6735M_65C_VF_L(LTTG_DSDS).mak"
LTTG_SOURCE_EXT_MAK="make/custom_config/JHZ6735M_65C_VF_L(LTTG_DSDS)_EXT.mak"
else
LWG_SOURCE_MAK="make/JHZ6735M_65C_VF_L(LWG_DSDS_${source_name}).mak"
LWG_SOURCE_EXT_MAK="make/custom_config/JHZ6735M_65C_VF_L(LWG_DSDS_${source_name})_EXT.mak"
LTTG_SOURCE_MAK="make/JHZ6735M_65C_VF_L(LTTG_DSDS_${source_name}).mak"
LTTG_SOURCE_EXT_MAK="make/custom_config/JHZ6735M_65C_VF_L(LTTG_DSDS_${source_name})_EXT.mak"
fi
LWG_DST_MAK="make/JHZ6735M_65C_VF_L(LWG_DSDS_${dest_name}).mak"
LWG_DST_EXT_MAK="make/custom_config/JHZ6735M_65C_VF_L(LWG_DSDS_${dest_name})_EXT.mak"
LTTG_DST_MAK="make/JHZ6735M_65C_VF_L(LTTG_DSDS_${dest_name}).mak"
LTTG_DST_EXT_MAK="make/custom_config/JHZ6735M_65C_VF_L(LTTG_DSDS_${dest_name})_EXT.mak"


################## start for lwg ############
cp -rf $LWG_SOURCE_MAK $LWG_DST_MAK
cp -rf $LWG_SOURCE_EXT_MAK $LWG_DST_EXT_MAK

sed_replace ${LWG_DST_MAK} MT6735_LTE_MT6169_${source_name}  MT6735_LTE_MT6169_${dest_name}
sed_replace ${LWG_DST_MAK} MT6735_2G_MT6169_${source_name}  MT6735_2G_MT6169_${dest_name}
sed_replace ${LWG_DST_MAK} MT6735_UMTS_FDD_MT6169_${source_name}  MT6735_UMTS_FDD_MT6169_${dest_name}
cat ${LWG_DST_MAK} | sed 's/^PROJECT_MAKEFILE_EXT = .*//g' | sed '$ i PROJECT_MAKEFILE_EXT = JHZ6735M_65C_VF_L(LWG_DSDS_'${dest_name}')_EXT' > rf_last
mv rf_last ${LWG_DST_MAK};

sed_replace ${LWG_DST_EXT_MAK} MT6735_LTE_MT6169_${source_name}  MT6735_LTE_MT6169_${dest_name}
sed_replace ${LWG_DST_EXT_MAK} MT6735_2G_MT6169_${source_name}  MT6735_2G_MT6169_${dest_name}
sed_replace ${LWG_DST_EXT_MAK} MT6735_MMRF_${source_name}  MT6735_MMRF_${dest_name}
sed_replace ${LWG_DST_EXT_MAK} MT6735_UMTS_FDD_MT6169_${source_name}  MT6735_UMTS_FDD_MT6169_${dest_name}


################## start for lttg ############
cp -rf $LTTG_SOURCE_MAK $LTTG_DST_MAK
cp -rf $LTTG_SOURCE_EXT_MAK $LTTG_DST_EXT_MAK

sed_replace ${LTTG_DST_MAK} MT6735_LTE_MT6169_${source_name}  MT6735_LTE_MT6169_${dest_name}
sed_replace ${LTTG_DST_MAK} MT6735_2G_MT6169_${source_name}  MT6735_2G_MT6169_${dest_name}
sed_replace ${LTTG_DST_MAK} MT6735_MT6169_UMTS_TDD_${source_name}  MT6735_MT6169_UMTS_TDD_${dest_name}
cat ${LTTG_DST_MAK} | sed 's/^PROJECT_MAKEFILE_EXT = .*//g' | sed '$ i PROJECT_MAKEFILE_EXT = JHZ6735M_65C_VF_L(LTTG_DSDS_'${dest_name}')_EXT' > rf_last
mv rf_last ${LTTG_DST_MAK};

sed_replace ${LTTG_DST_EXT_MAK} MT6735_LTE_MT6169_${source_name}  MT6735_LTE_MT6169_${dest_name}
sed_replace ${LTTG_DST_EXT_MAK} MT6735_2G_MT6169_${source_name}  MT6735_2G_MT6169_${dest_name}
sed_replace ${LTTG_DST_EXT_MAK} MT6735_MMRF_${source_name}  MT6735_MMRF_${dest_name}
sed_replace ${LTTG_DST_EXT_MAK} MT6735_MT6169_UMTS_TDD_${source_name}  MT6735_MT6169_UMTS_TDD_${dest_name}

chmod 775 $LWG_DST_MAK
chmod 775 $LTTG_DST_MAK
chmod 775 $LWG_DST_EXT_MAK
chmod 775 $LTTG_DST_EXT_MAK
