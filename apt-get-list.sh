#!/bin/sh
#
# File: apt-get-list.sh
#
# Created: 星期三, 七月 24 2013 by Hua Liang[Stupid ET] <et@everet.org>
#

apt-get -y install ttf-mscorefonts-installer ack-grep zsh emacs vim dosbox virtualbox inotify-tools
apt-get -y install libnotify4 python-gobject

apt-get build-dep emacs

# for emacs jedi
pip install jedi epc
