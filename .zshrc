#### ~/.zshrc

# ----------------------------
# Basic Environment Settings
# ----------------------------

# Color support
autoload -U colors && colors

# Enable command correction & completion
setopt correct
autoload -Uz compinit && compinit

# Use vim keybindings in Zsh
bindkey -v

# ----------------------------
# LS Colors
# ----------------------------
# LSCOLORS order: 
# directory, symbolic link, socket, pipe, executable, block, char, executable w/ setuid bit, executable w/ setgid bit, directory writable to others, directory writable to others w/ sticky bit
export LSCOLORS="GxFxBxDxCxgggdabagacad"  # Nice vibrant scheme

# Aliases for ls with colors
alias ls='ls -lGFh'
alias la='ls -GFlA'

# ----------------------------
# Prompt Configuration
# ----------------------------

# Colors
USER_COLOR="%{$fg[yellow]%}"
DIR_COLOR="%{$fg[green]%}"
BRANCH_COLOR="%{$fg[cyan]%}"
RESET="%{$reset_color%}"

USER_PROMPT="[🐵]"

# ----------------------------
# vcs_info Setup
# ----------------------------

autoload -Uz vcs_info

# Enable git (and others if needed)
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' branchformat '%b'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a)'
zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:*' check-for-changes false

# Update vcs_info before each prompt
precmd() { vcs_info }

# Prompt substitution
setopt PROMPT_SUBST
PROMPT='${USER_COLOR}${USER_PROMPT}${RESET} ${DIR_COLOR}%~${RESET}${BRANCH_COLOR}${vcs_info_msg_0_}${RESET} > '

# ----------------------------
# Tmux-Friendly Settings
# ----------------------------
if [[ -z "$TMUX" && -n "$PS1" && -z "$SSH_CLIENT" && -t 1 ]]; then
  # Check if tmux server is running
  if tmux has-session -t root 2>/dev/null; then
    # Attach to existing "root" session
    tmux attach -t root
  else
    # Create "root" session and attach
    tmux new-session -s root
  fi
fi


# Make sure terminal supports 256 colors
export TERM="xterm-256color"

# Better tmux + zsh key handling
bindkey -e
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^R' history-incremental-search-backward

# Allow tmux to have larger scrollback buffer
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# Env variables
export GH_TOKEN=
