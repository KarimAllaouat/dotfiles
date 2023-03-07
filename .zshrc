# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump brew auto-color-ls)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

eval "$(rbenv init -)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval $(thefuck --alias)
eval "$(starship init zsh)"

gtidy() {
  if [[ -z $1 ]]
  then
    echo "Please provide a branch name (eg develop) as an argument"
    return 1
  fi
  gco $1 && git fetch && git branch | grep -v $1 | xargs git branch -D && git pull
}

oclogs() {
  oc get pods | grep $1 | grep $2 | grep Running | awk '{print $1;}' | xargs oc logs
}

CODE_DIR=$HOME/git

checkenv() {
  if [[ -z $1 ]]
  then
    echo "Please provide an environment name (eg concorde1) as an argument"
    return 1
  fi
  env_name=$1
  cd $HOME/hmlr-git/openshift-config
  git fetch
  git diff origin/develop origin/env/$env_name
  cd -
}

seeBranches() {
  user=${1:-"karim"}   
  echo -n "" > branches.txt
  for repo in */; do
    if [ -d "${repo}" ]; then
      echo "${repo}..."
      cd "$repo" || { echo "Failed to enter folder ${repo}"; exit 1; }
      git fetch
      for branch in $(git branch -r | grep -v HEAD); do
        echo -e "${repo%?}: $(git show --format="%ai %ar by %an" "$branch" | head -n 1)" \\t"$branch"
      done | sort -r | grep -i $user | tee -a ../branches.txt
      cd ..
      echo ""
    fi
  done
}

seeBranchesAndNuke() {
  user=${1:-"karim"}
  echo -n "" > branches.txt
  for repo in */; do
    if [ -d "${repo}" ]; then
      echo "${repo}..."
      cd "$repo" || { echo "Failed to enter folder ${repo}"; exit 1; }
      gtidy master
      for branch in $(git branch -r | grep -v HEAD); do
        echo -e "${repo%?}: $(git show --format="%ai %ar by %an" "$branch" | head -n 1)" \\t"$branch"
      done | sort -r | grep -i $user | tee -a ../branches.txt
      cd ..
      echo ""
    fi
  done
}

alias idea="open -na 'IntelliJ IDEA.app' --args '$@'"
alias zsh=" code ~/.zshrc"
alias om-ports=""

tput smam

[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
PATH=$(pyenv root)/shims:$PATH

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
source /Users/user1/.docker/init-zsh.sh || true # Added by Docker Desktop
