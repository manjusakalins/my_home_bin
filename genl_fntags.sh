#!/bin/sh
# generate tag file for lookupfile plugin
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
#find . -not -regex '.*\.\(png\|gif\|bmp\|o\|d\)' -type f -printf "%f\t%p\t1\n" | \
find -L . -regex '.*\.\(mk\|c\|cpp\|h\|s\|S\|ld\|java\)' -type f -printf "%f\t%p\t1\n" | \
    sort -f >> filenametags.o
