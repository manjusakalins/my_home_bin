function makeone()
{
    ./make.sh "$mdmk" new $bandn
    cd /media/newdata/all_new_code/kk_6582/mediatek/build/tools
    ./modemRenameCopy.pl $MD_PATHS $MD_PRONAME
    cd $MD_PATHS
    rm -rf gen_modem$bandn
    cp -rf temp_modem gen_modem$bandn
}

mdmk=$(ls make | grep HSPA)
MD_PRONAME=$(ls make | grep HSPA | awk -F. '{print $1}')
MD_PATHS=$(pwd)
bandn=$1
echo $allband
echo $MD_PRONAME
echo $MD_PATHS
if [ "$bandn" == "all" ]
then
    echo "build all"
    echo ============================================================
    bandlist=$(ls custom/modem/ul1_rf/ | grep b)
    echo $bandlist
    for curband in $bandlist
    do
        echo $curband
        bandn=$curband
        makeone 
    done
else
    makeone $bandn
fi

