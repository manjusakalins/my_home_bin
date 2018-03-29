 find . -name "CFG_WIFI_Defa*" | awk '{system("cp ./S960/vendor/mediatek/proprietary/custom/S960/cgen/cfgdefault/CFG_WIFI_Default.h "$1)}'
 
 grep "AP_CFG_RDEB_FILE_WIFI_LID_VERNO" * -R | awk -F: '{print $1}' | sort | uniq | xargs sed -i '/AP_CFG_RDEB_FILE_WIFI_LID_VERNO/c #define AP_CFG_RDEB_FILE_WIFI_LID_VERNO  "001"'



find . -name "*BPLGUInfoCustomApp_MT6735_S00_MOLY_LR9_W1444_MD_LWTG_MP_V79*"  | sed -n '/P61/!p'| awk '{system("rm "$1)}'

