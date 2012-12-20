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

#install pymacs
#install rope
#install ropemode
#install ropemacs

apt-get install -y libxml2 libxml2-dev w3m ncurses-base libncurses5-dev clang slime sbcl clisp python-pip texinfo pydb texlive-latex-base
pip install pyflakes pep8 rope ropemacs

# install doxymacs-1.8.0
# install cscope-15.7a

