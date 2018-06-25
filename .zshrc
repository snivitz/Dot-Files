# vi emulation
bindkey -v

# exports
export EDITOR=vim
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/local:
export TERM="xterm-256color"
export PAGER=less
export LESS="--ignore-case --long-prompt"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# aliases
alias sc="screen"
alias ls="ls -G"
alias lsa='ls -ld .*'

# prevent overwriting of files by redirects
setopt noclobber

# setting the charset 'less' should use
LESSCHARSET=utf-8

