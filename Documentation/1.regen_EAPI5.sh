#!/bin/sh

if [ -z $1 ]; then
    dir="$1"
else
    dir=""
fi
find ../${dir} -type f -name '*.ebuild' -print0 | xargs -0 sed -r -e 's/EAPI="?[2345]"?/EAPI=5/' -i
