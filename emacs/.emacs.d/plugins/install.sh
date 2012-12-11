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

add-apt-repository ppa:irie/elisp
apt-get update
apt-get install ibus-el

install pymacs
install rope
install ropemode
install ropemacs
apt-get install -y libxml2 libxml2-dev w3m ncurses-base libncurses5-dev cscope clang slime sbcl clisp python-pip ecb
pip install pyflakes pep8

install doxymacs-1.8.0
install cscope-15.7a

cat > ~/bin/pycheckers <<EOF
#!/bin/bash

pyflakes "$1"
pep8 --ignore=E221,E701,E202 --repeat "$1"
true
EOF

chmod +x ~/bin/pycheckers