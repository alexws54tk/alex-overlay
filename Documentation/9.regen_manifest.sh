#!/bin/sh

find ../ -type f -iname '*.ebuild' | { [[ $@ ]] && grep $@ || cat; } | xargs -I{} ebuild {} digest
