# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

export TERM=xterm-256color
export SHELL=zsh


# Example aliases
alias zshconfig="ec ~/.zshrc"
alias ohmyzsh="ec ~/.oh-my-zsh"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias n4='ssh -l root -p 1990 new.everet.org'
alias ras='ssh -l root -p 1990 ras.everet.org'
alias ec='emacsclient -t -a=""'
alias se='SUDO_EDITOR="emacsclient -t" sudo -e'
alias gs='git status'
alias gp='git push'
alias gpt='git push --tags'
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias ra='ranger'
alias i='info'
alias rp='rake publish'
alias rgp='rake generate && rake preview'
alias ipy='ipython'
alias ack='ACK_PAGER_COLOR="less -x4SRFX" /usr/bin/ack-grep -a'
alias sc='screen'
alias scb='screen -dr normaltask || screen -S normaltask'
alias tmb='tmux -2 attach -t normaltask || tmux -2 new -s normaltask'
alias ms='mysql -u root -p'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh


# Customize to your needs...

# disable auto correct
unsetopt correct_all

# autojump
[[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh

# man
vman () {
    export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
                     vim -R \
                     -c 'set ft=man nomod nolist' \
                     -c 'map q :q!<CR>' \
                     -c 'map d <C-D>' \
                     -c 'map u <C-U>' \
                     -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

    # invoke man page
    man $1

    # we muse unset the PAGER, so regular man pager is used afterwards
    unset PAGER
}

alias man=vman
