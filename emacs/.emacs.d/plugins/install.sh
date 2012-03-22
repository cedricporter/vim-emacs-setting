#!/bin/sh
install()
{
    echo $1
    cd $1
    make
    python setup.py install
    cd ..
}

install Pymacs
install rope-0.9.3
install ropemode-0.1-rc2
install ropemacs
