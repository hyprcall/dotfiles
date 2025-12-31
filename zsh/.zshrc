# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---------- Shell basics ----------
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_DUPS          # don't record immediate dupes
setopt HIST_IGNORE_ALL_DUPS      # remove older dupes when adding a command
setopt HIST_REDUCE_BLANKS        # trim superfluous spaces
setopt INC_APPEND_HISTORY        # append to $HISTFILE as you go
setopt SHARE_HISTORY             # share history across sessions

bindkey -v                       # vi-mode

# Load the available widgets
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# If you use vi-mode, bind in the vi insert map
bindkey -M viins '^[[A' up-line-or-beginning-search   # Up arrow
bindkey -M viins '^[[B' down-line-or-beginning-search # Down arrow

# (Optional) also in emacs map, just in case
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# ---------- Completion ----------
autoload -Uz compinit
zmodload zsh/complist            # needed for menu selection UI

# Skip security prompts if permissions look weird; you can run `compaudit` manually later
compinit -i

# Core completers: normal complete, then command-name correction
zstyle ':completion:*' completer _complete _correct

# Matching strategy (tries in order):
# 1) normal
# 2) case-insensitive
# 3) substring (match anywhere; nice for long paths/branches)
zstyle ':completion:*' matcher-list \
  '' \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*'

# Nice UI/behavior
zstyle ':completion:*' menu select               # arrow keys to pick
zstyle ':completion:*' group-name ''             # group by type
zstyle ':completion:*:descriptions' format '%F{cyan}%d%f'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-packed yes
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs false        # don't show . and .. unless typed

# Use LS_COLORS for colored lists (falls back gracefully if unset)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Speed up heavy completions (e.g., hosts) with a cache
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zcompcache

# Complete for hidden files when you start with a dot
zstyle ':completion:*:paths' hidden yes

# Mild correction behavior (for commands only; data args left alone)
setopt CORRECT          # turn off by commenting this line if it bugs you
# setopt NOCORRECT      # (alternative) never correct anything

# ---------- Completion navigation fixes ----------
# Allow cycling forward/backward through completion lists
bindkey '^I' menu-complete                     # Tab = forward
bindkey '^[[Z' reverse-menu-complete           # Shift+Tab = backward
bindkey -M menuselect '^[[Z' reverse-menu-complete  # inside menu select mode

# ---------- Prompt (simple, no plugins) ----------
# Feel free to change; kept minimal and fast
PROMPT='%F{green}%n@%m%f %F{blue}%~%f %# '

# ---------- Misc quality-of-life ----------
setopt AUTO_PUSHD                     # pushd/popd dir stack with cd
setopt PUSHD_IGNORE_DUPS
setopt EXTENDED_GLOB                  # powerful globbing
setopt NO_BEEP

# ---------- File: record where compinstall (if ever) would write ----------
zstyle :compinstall filename "$HOME/.zshrc"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -------- LSD alises ----------
alias ls='lsd --group-dirs=first --color=auto'
alias ll='lsd -l --group-dirs=first --color=auto'
alias la='lsd -la --group-dirs=first --color=auto'
alias lt='lsd --tree'

# -------- Bat aliases ---------
alias bat='bat --paging=always --style=header,grid,numbers --pager="less -R -F -S"'

# -------- dircolors ---------
eval "$(dircolors -b ~/.dircolors)"

# -------- Gemini ----------
alias gemini='cd ~/Gemini && gemini'
export PATH=/home/hypr/.local/bin:/home/hypr/.local/share/zinit/polaris/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/rocm/bin
