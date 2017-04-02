# vi emulation
bindkey -v

# lhs prompt: user@hostname
# PS1='%n@%M%% '
# PS1="$(print '%{\e[;31m%}%n%{\e[;0m%}@%{\e[;30m%}%m%{\e[0;37m%}[%~]%{\e[0m%}% ')"
# rhs prompt: pwd upto a max of 20 chars
# RPS1='%20<..<%~'

# exports
export WWW_HOME=http://daringfireball.net
export NNTPSERVER=news.sunsite.dk
export EDITOR=vim
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/local:
export TERM="xterm-256color"
export SENDMAIL=/usr/bin/nbsmtp
export PAGER=less
export LESS="--ignore-case --long-prompt"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# aliases
alias sc="screen"
alias ls="ls -G"
alias fetchmail="fetchmail -a -m 'procmail -d %T'"
alias lsa='ls -ld .*'
alias pi="ssh pi@172.16.1.3"
alias st="ssh pi@106.51.225.167"

# emerge autocompletion?/ Doesn't work
autoload -U compinit promptinit
compinit
promptinit; prompt off

# prevent overwriting of files by redirects
setopt noclobber

# setting the charset 'less' should use
LESSCHARSET=utf-8

# oh-my-zsh
# export ZSH=$HOME/.oh-my-zsh
source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
# source $ZSH/oh-my-zsh.sh
# ZSH_THEME="agnoster"

# Brew CoreUtils
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
