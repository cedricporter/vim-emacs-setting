#!/bin/sh
#
# File: vman.sh
#
# Created: Friday, March  1 2013 by Hua Liang[Stupid ET] <et@everet.org>
#

# export PAGER="col -b | view -c 'set ft=man nomod nolist' - "
export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
                     vim -R \
                     -c 'set ft=man nomod nolist' \
                     -c 'map q :q!<CR>' \
                     -c 'map d <C-D>' \
                     -c 'map u <C-U>' \
                     -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

# export MANPAGER="/usr/bin/most -s"
man $*
