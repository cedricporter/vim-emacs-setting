#!/bin/sh
#
# File: apt-get-list.sh
#
# Created: 星期三, 七月 24 2013 by Hua Liang[Stupid ET] <et@everet.org>
#

apt-get update

apt-get -y install ttf-mscorefonts-installer ack-grep zsh emacs vim dosbox virtualbox inotify-tools
apt-get -y install libnotify4 python-gobject mercurial git git-svn bzr python-pygments xclip

apt-get -y intall graphviz ruby1.9.3 rubygems tmux htop

apt-get build-dep emacs24

apt-get -y install libnotify-dev python-gobject libnotify4

# for emacs jedi
apt-get -y install python-pip python-dev build-essential ipython python-openssl

pip install jedi epc remote-webkit-debug pylint virtualenv jedi epc

gem install teamocil bundler
