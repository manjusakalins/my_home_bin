#!/bin/sh
# generate tag file for lookupfile plugin
echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
find . \( -path '*\.git' -o -path ./out -o -path '\.repo' \) -prune -o -not -regex '.*\.\(png\|gif\|js\|html\)' -type f -printf "%f\t%p\t1\n" | sort -f >> filenametags
#find . -not -regex '.*\.\(png\|gif\)' -type f -printf "%f\t%p\t1\n" | sort -f >> filenametags
