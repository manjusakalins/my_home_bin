MAKEFILES=$1
echo $MAKEFILES
echo ${MAKEFILES/.mak//}
if [[ $MAKEFILES == "all" ]]
then
    echo "build all"
    for file in $(ls make)
    do
        echo $file
        #if [[ $file == *"LWG"* ]] || [[ $file == *"LTTG"* ]]
        if [[ $file == *"LTTG"* ]] || [[ $file == *"LWG"* ]]
        then
            dirname=${file/.mak/}
            echo $dirname
            $(pwd)/./make.sh "$file" new
            perl /home/manjusaka/all_codes/6735l1/device/mediatek/build/build/tools/modemRenameCopy.pl $(pwd) "$file"
            perl /home/manjusaka/all_codes/6735l1/device/mediatek/build/build/tools/modemRenameCopy.pl $(pwd) "$dirname"
            mv temp_modem "$file"
        fi
    done

else

$(pwd)/./make.sh "$MAKEFILES" new
dirname=${MAKEFILES/.mak/}
perl /home/manjusaka/all_codes/6735l1/device/mediatek/build/build/tools/modemRenameCopy.pl $(pwd) "$MAKEFILES"
perl /home/manjusaka/all_codes/6735l1/device/mediatek/build/build/tools/modemRenameCopy.pl $(pwd) "$dirname"
mv temp_modem "$MAKEFILES"
fi
