# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="juanghurtado"  #"robbyrussell"

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
plugins=(vagrant brew bundler encode64 git git-flow github gem npm osx cake svn command-not-found autojump coffee pip pep8 python ruby rvm tmux supervisor debian)

source $ZSH/oh-my-zsh.sh


# Customize to your needs...

# has bugs with teamocil
export DISABLE_AUTO_TITLE="true"

setopt share_history
autoload -U zmv

# bash completion
autoload bashcompinit
bashcompinit

compctl -g '~/.teamocil/*(:t:r)' teamocil

bash_completion_list=("/etc/bash_completion.d/igor"
    # "/etc/bash_completion.d/ack-grep"
)
for f in $bash_completion_list; do
    [[ -s $f ]] && source $f;
done

# export EDITOR='emacsclient -t -a="" +%d %s'

# Example aliases
alias pc="proxychains4"
alias zshconfig="ec ~/.zshrc"
alias zshreload="source ~/.zshrc"
# alias ohmyzsh="ec ~/.oh-my-zsh"

alias to="teamocil --here"

alias tp='gtypist'

alias gitroot='cd $(git rev-parse --show-cdup)'

alias ls="ls --color=auto"
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'
alias lst='ls -tr'
alias lsd='ls -d */'		# list dir
alias lsdt='ls -dt */ '		# list dir
alias dud='du -hs * | sort -h'

alias 84='ssh -l root -p 1990 84.everet.org'
alias sscp='scp -r -P 32200 '
alias ras='ssh -l root -p 1990 ras.everet.org'
alias n46='ssh -l root -p 1990 ipv6.everet.org'
alias ssh2='ssh -l gzhualiang -p 32200 '
alias ras6='ssh -t -p 1990 root@ipv6.everet.org ssh -p 1990 root@ras.everet.org'
alias debian='ssh -l root debian.xxx'
alias linode='ssh -A -p 1990 root@linode.everet.org'
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
alias iglt='igor log.tail'

# svn
function svn_repo {
    repo=`svn info | sed -n "s/URL: //p" | sed -n "s/\/$(svn_get_branch_name)//p"`
    return $repo
}
alias ss='svn status'
alias sdgbk='luit -encoding gbk svn diff'
alias sd='svn diff'
alias scm='svn commit -m '
alias sls='svn log --stop-on-copy'
alias sl='svn log --limit 5'
alias svn_br='svn ls -v $(svn_repo)/branches'

# git
alias gr='gitroot'
alias gs='git status'
alias gp='git push'
alias gf='git flow'
alias gpt='git push --tags'
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias gcam='git commit -am '
alias gcm='git commit -m '
alias gitproxy='export GIT_PROXY_COMMAND="~/bin/proxy-wrapper"'
alias ungitproxy='export GIT_PROXY_COMMAND=""'
alias gsfpl='git submodule foreach git pull'
alias gdlast='git diff HEAD^ HEAD'

alias ra='ranger'
alias i='info'

alias rp='rake publish'
alias rgp='rake generate && rake preview'

alias ipy='ipython'
alias ack='ACK_PAGER_COLOR="less -x4SRFX" ack '

alias ag='\ag --pager "less -R"'

alias sc='screen'
alias scb='screen -dr normaltask || screen -S normaltask'

# tmux
custom_tmux() {
    tmux -2 attach -t $1 || tmux -2 new -s $1
}

alias tmux='tmux -2'
alias tmb='tmux -2 attach -t normaltask || tmux -2 new -s normaltask'
alias tmn=custom_tmux


alias ms='mysql -u root'
alias msgbk='luit -encoding gbk mysql -u root'

# Easily search running processes (alias).
alias 'psg'='ps auxf | grep '
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
alias rm="trash-put"

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

PROMPT='%{$fg_bold[red]%}@ %{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(svn_prompt_info)$(git_prompt_info)$(git_prompt_ahead)%{$fg_bold[blue]%} %# %{$reset_color%}'

# Prompt format
RPROMPT='$FG[244] %n@%m%{$reset_color%}'

# SVN
SVN_SHOW_BRANCH="true"

ZSH_THEME_SVN_PROMPT_AHEAD="%{$fg[yellow]%} * %{$reset_color%}"
ZSH_THEME_SVN_PROMPT_PREFIX="svn:(%{$fg[red]%}"
ZSH_THEME_SVN_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_SVN_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}x%{$reset_color%}"
ZSH_THEME_SVN_PROMPT_CLEAN="%{$fg[blue]%})"


# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[yellow]%} * %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}x%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
# ------------------------- theme -------------------------

# entertainment
alias matrix='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'



if [ -d "/usr/local/opt/coreutils/libexec/gnubin" ] ; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi
if [ -d "/usr/local/opt/coreutils/libexec/gnuman" ] ; then
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi
if [ -d "/usr/local/bin" ] ; then
    export PATH="/usr/local/bin:$PATH"
fi


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/local/bin" ] ; then
    PATH="$HOME/local/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/local/lib" ] ; then
    LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"
fi
if [ -d "$HOME/npm/bin" ] ; then
    PATH="$HOME/npm/bin:$PATH"
fi


# export LC_CTYPE="zh_CN.UTF-8"

if [ -d "/usr/lib/jvm/jdk7" ] ; then
    export JAVA_HOME=/usr/lib/jvm/jdk7
    export JRE_HOME=${JAVA_HOME}/jre
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
    export PATH=${JAVA_HOME}/bin:$PATH

    # Android SDK
    export ANDROID_SDK=$HOME/adt-bundle-linux-x86_64-20131030/sdk
    export PATH=$ANDROID_SDK/platform-tools:$ANDROID_SDK/tools:$PATH
fi

# do some os specific config
if [ "$(uname)" = "Darwin" ]; then
    alias 'psg'='ps aux | grep '
    # Do something under Mac OS X platform
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    # Do something under Linux platform
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
    # Do something under Windows NT platform
fi

export SVN_EDITOR=vim
export EDITOR=vim

export COCOS_CONSOLE_ROOT=$HOME/cocos2d-x/tools/cocos2d-console/bin
export PATH=$COCOS_CONSOLE_ROOT:$PATH
export ANDROID_SDK_ROOT=$HOME/adt-bundle-mac-x86_64-20131030/sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH
export ANT_ROOT=/usr/local/bin/
export PATH=$ANT_ROOT:$PATH
export QUICK_V3_ROOT=`cat ~/.QUICK_V3_ROOT`

if [ -d "$HOME/android-ndk/android-ndk-r9d/" ]; then
    export NDK_ROOT="$HOME/android-ndk/android-ndk-r9d/"
    export NDKROOT=$NDK_ROOT
    export ANDROID_NDK_ROOT=$NDK_ROOT
    export PATH=$NDK_ROOT:$PATH
fi
if [ -d "$HOME/adt-bundle-mac-x86_64-20131030/sdk" ]; then
    export ANDROID_SDK_ROOT=$HOME/adt-bundle-mac-x86_64-20131030/sdk
fi

# add by quick-cocos2d-x setup, DATE: 2014-11-05 TIME: 14:22:56
export QUICK_COCOS2DX_ROOT=`cat ~/.QUICK_COCOS2DX_ROOT`

random-string()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# mount the android file image
function mountAndroid { hdiutil attach ~/android.dmg -mountpoint /Volumes/android; }
