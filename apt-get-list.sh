#!/bin/sh
#
# File: apt-get-list.sh
#
# Created: 星期三, 七月 24 2013 by Hua Liang[Stupid ET] <et@everet.org>
#

apt-get update

apt-get -y install ttf-mscorefonts-installer ack-grep zsh emacs vim dosbox virtualbox inotify-tools
apt-get -y install libnotify4 python-gobject mercurial git git-svn bzr python-pygments

apt-get -y graphviz ruby1.9.3 rubygems

apt-get build-dep emacs

# for emacs jedi
apt-get -y install python-pip python-dev build-essential ipython
pip install jedi epc remote-webkit-debug pylint virtualenv

gem install teamocil bundler
