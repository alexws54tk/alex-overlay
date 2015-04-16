#!/bin/sh

find $(dirname $0)/../ -iname '*.ebuild' | { [[ $@ ]] && grep $@ || cat; } | xargs -I{} ebuild {} digest --force
