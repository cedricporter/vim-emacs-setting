#! /bin/sh

# link to $HOME
echo "# Creating link in your $HOME dir..."
mv ~/.emacs ~/.emacs-old
mv ~/.emacs.d ~/.emacs.d-old
mv ~/.vimrc ~/.vimrc-old
mv ~/.vim ~/.vim-old

ln -vsf $PWD/emacs/.emacs ~/.emacs
ln -vsf $PWD/emacs/.emacs.d ~/.emacs.d
ln -vsf $PWD/vim/.vimrc ~/.vimrc
ln -vsf $PWD/vim/.vim ~/.vim

ln -vsf $PWD/.zshrc ~/.zshrc
ln -vsf $PWD/.tmux.conf ~/.tmux.conf


# pull submodule
echo "# Pulling submodule"
git submodule init
git submodule update

# # auto-complete submdule
# echo "# Pulling submodule of auto-complete"
# current_dir=$PWD
# cd emacs/.emacs.d/plugins/auto-complete
# echo "cd $PWD"
# git submodule init
# git submodule update
# cd $current_dir
# echo "cd $PWD"
