# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# export TERM=xterm-256color
export SHELL=zsh


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
plugins=(git cake command-not-found autojump coffee pip supervisor debian)

source $ZSH/oh-my-zsh.sh


# Customize to your needs...

autoload -U zmv

# bash completion
autoload bashcompinit
bashcompinit

bash_completion_list=("/etc/bash_completion.d/igor"
    # "/etc/bash_completion.d/ack-grep"
)
for f in $bash_completion_list; do
    [[ -s $f ]] && source $f;
done

# export EDITOR='emacsclient -t -a="" +%d %s'

# Example aliases
alias zshconfig="ec ~/.zshrc"
alias zshreload="source ~/.zshrc"
# alias ohmyzsh="ec ~/.oh-my-zsh"

alias tp='gtypist'

alias gitroot='cd $(git rev-parse --show-cdup)'

alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'
alias lst='ls -tr'
alias lsd='ls -d */'		# list dir
alias lsdt='ls -dt */ '		# list dir
alias dud='du -hs * | sort -h'

alias n4='ssh -l root -p 1990 new.everet.org'
alias ras='ssh -l root -p 1990 ras.everet.org'
alias n46='ssh -l root -p 1990 ipv6.everet.org'
alias ras6='ssh -t -p 1990 root@ipv6.everet.org ssh -p 1990 root@ras.everet.org'
alias debian='ssh -l root debian.xxx'
alias sah='ssh-add ~/.ssh/id_rsa_home'
alias saw='ssh-add ~/.ssh/id_rsa_work'

alias ec='emacsclient -t -a=""'
alias se='SUDO_EDITOR="emacsclient -t" sudo -e'

# syntax highlight cat
alias ccat='pygmentize -g'
alias pylint='pylint --output-format=colorized'

alias igms='igor mysql'
alias igdp='igor deploy -nc'
alias igop='igor open'

# git
alias gs='git status'
alias gp='git push'
alias gpt='git push --tags'
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias gcam='git commit -am '
alias gitproxy='export GIT_PROXY_COMMAND="~/bin/proxy-wrapper"'
alias ungitproxy='export GIT_PROXY_COMMAND=""'

alias ra='ranger'
alias i='info'

alias rp='rake publish'
alias rgp='rake generate && rake preview'

alias ipy='ipython'
alias ack='ACK_PAGER_COLOR="less -x4SRFX" /usr/bin/ack-grep -a'

alias sc='screen'
alias scb='screen -dr normaltask || screen -S normaltask'
alias tmb='tmux -2 attach -t normaltask || tmux -2 new -s normaltask'
alias tmn='tmux -2 new -s "`mktemp`"'
alias ms='mysql -u root -p'

# Easily search running processes (alias).
alias 'psg'='ps aux | grep '
alias 'psl'='ps awwfux | less -S'

# apt-get
alias ai='sudo apt-get install '

# display
alias single-display="xrandr --output VGA-0 --off"
alias double-display="xrandr --output VGA-0 --left-of LVDS-0 --auto"

# goagent
alias goagent="export http_proxy=127.0.0.1:8087 && export https_proxy=127.0.0.1:8087"
alias ungoagent="export http_proxy= && export https_proxy="

# ssh
alias sshproxy="cp ~/.ssh/config-proxy ~/.ssh/config"
alias unsshproxy="rm ~/.ssh/config"

# safe rm
# alias rm='rm -i'
mkdir -p ~/.trash
alias rm=trash
alias rl='ls ~/.trash'
alias ur=undelfile
undelfile()
{
    mv -i ~/.trash/$@ ./
}
trash()
{
    mv --verbose -f --backup=numbered --target-directory ~/.trash/ $@
}
cleartrash()
{
    vared -c -p "y/n" confirm
    echo $confirm
    [[ $confirm == 'y' ]] || [[ $confirm == 'Y' ]] && \rm -rf ~/.trash/*
}

# kill processes that match pattern
psgkill()
{
    processes=`ps aux | grep $1 | grep -v grep`
    if [ -n "$processes" ]; then
	pids=`echo $processes | awk '{print $2}'`
	echo "Killing processes matched \"$1\":"
	echo "$processes"
	echo -n "Are you sure to kill all of them. [Y/n]: "
	read y_or_n
	if [ "$y_or_n" = "y" -o "$y_or_n" = "Y" -o -z "$y_or_n" ]; then
	    echo $pids | xargs kill
	fi
    else
	echo "Not found any processes match pattern \"$1\""
    fi
}

# disable auto correct
unsetopt correct_all

# # autojump
# [[ -s /etc/profile.d/autojump.sh ]] && . /etc/profile.d/autojump.sh

# man
vman () {
    export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
                     vim -R \
                     -c 'set ft=man nomod nolist' \
                     -c 'map q :q!<CR>' \
                     -c 'map d <C-D>' \
                     -c 'map u <C-U>' \
                     -c 'map j <C-E>' \
                     -c 'map k <C-Y>' \
                     -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

    # invoke man page
    man $*

    # we muse unset the PAGER, so regular man pager is used afterwards
    unset PAGER
}

alias man=vman                  # use \man to invoke original man

# cd path
# CDPATH=:..:~:~/projects

# ========================= theme =========================
# prompt, forked from robbyrussell
PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)$(git_prompt_ahead)%{$fg_bold[blue]%} %# %{$reset_color%}'

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[yellow]%} ⚙ %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
# ------------------------- theme -------------------------

# entertainment
alias matrix='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'



# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# export LC_CTYPE="zh_CN.UTF-8"
