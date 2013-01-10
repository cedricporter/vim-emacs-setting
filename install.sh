#! /bin/sh

# link to $HOME
echo "# Creating link in your $HOME dir..." 
ln -s $PWD/vim-emacs-setting/emacs/.emacs ~/.emacs
ln -s $PWD/vim-emacs-setting/emacs/.emacs.d ~/.emacs.d
ln -s $PWD/vim-emacs-setting/vim/.vimrc ~/.vimrc
ln -s $PWD/vim-emacs-setting/vim/.vim ~/.vimc

# pull submodule
echo "# Pulling submodule"
git submodule init
git submodule update

# auto-complete submdule
echo "# Pulling submodule of auto-complete"
current_dir=$PWD
cd emacs/.emacs.d/plugins/auto-complete
echo "cd $PWD"
git submodule init
git submodule update

cd $current_dir
echo "cd $PWD"





