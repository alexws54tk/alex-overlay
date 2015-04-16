#!/bin/sh

cd ..
find -iname '*.ebuild' | { [[ $@ ]] && grep $@ || cat; } | xargs -I{} ebuild {} digest --force
