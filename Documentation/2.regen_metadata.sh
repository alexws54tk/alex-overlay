#!/bin/sh

find ../ -type f -name 'metadata.xml' -print0 | xargs -0 sed -r -e "s!http://www.gentoo.org/dtd/metadata.dtd!https://www.gentoo.org/dtd/metadata.dtd!" -i

