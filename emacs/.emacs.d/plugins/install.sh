#!/bin/sh
install()
{
    echo $1
    cd $1
    ./configure
    make && make install
    python setup.py install
    cd ..
}

install pymacs
install rope
install ropemode
install ropemacs
apt-get install -y libxml2 libxml2-dev w3m ncurses-base libncurses5-dev cscope clang slime sbcl clisp


install doxymacs-1.8.0
install cscope-15.7a
