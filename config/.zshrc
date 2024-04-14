# ---- ZSH CONFIG ---- #
export ZSH="$HOME/.oh-my-zsh"
CASE_SENSITIVE="true"
DISABLE_MAGIC_FUNCTIONS="true"
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7
tput smam # toggle line wrapping

# ---- PLUGINS ---- #
plugins=(
  auto-color-ls
  autojump
  brew
  colored-man-pages
  docker
  extract
  fzf
  git
  git-open
  thefuck
  web-search
  zsh-autosuggestions
  zsh-bat
  zsh-syntax-highlighting
)

eval $(thefuck --alias)
eval "$(starship init zsh)"
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ---- ALIASES ---- #
alias c="clear"
alias gcob='git checkout -b'
alias idea="open -na 'IntelliJ IDEA.app' --args '$@'"
alias myip='curl http://ipecho.net/plain; echo'
alias reload='source ~/.zshrc'
alias zsh=" code ~/.zshrc"

gtidy() {
  if [[ -z $1 ]]
  then
    echo "Please provide a branch name (eg develop) as an argument"
    return 1
  fi
  gco $1 && git fetch && git branch | grep -v $1 | xargs git branch -D && git pull
}

source $ZSH/oh-my-zsh.sh