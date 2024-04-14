# Terminal setup

1. Install nerd-font
   - `brew tap homebrew/cask-fonts`
   - `brew install --cask font-jetbrains-mono-nerd-font`
2. Copy [.zshrc](./config/.zshrc) into home directory
3. Install [iTerm](https://iterm2.com)
   - Import [profile](./config/Karim's%20iTerm%20Profile.json)
   - General
     - Closing - <span style="color:red">Disable</span> confirm quit
     - Selection - <span style="color:red">Disable</span> copy to pasteboard on selection
   - Appearance
     - General - Set theme to Minimal
     - Windows
       - <span style="color:red">Disable</span> "Show window number"
       - <span style="color:green">Enable</span> hide scrollbar
     - Tabs - <span style="color:green">Enable</span> "Show tab bar"
4. Install [oh-my-zsh](https://ohmyz.sh)
5. Install [Starship](https://starship.rs) and copy [starship.toml](./config/starship.toml) file to .config directory
6. Create a file called `~/.hushlogin` to remove the last login message
7. Install plugins
   - Plugins from oh-my-zsh (no install needed)
     - brew
     - colored-man-pages
     - docker
     - extract
     - git
     - thefuck
     - web-search
   - Plugins to install
     - [auto-color-ls](https://github.com/gretzky/auto-color-ls)
     - [autojump](https://github.com/wting/autojump)
     - [git-open](https://github.com/paulirish/git-open)
     - [fzf](https://github.com/junegunn/fzf)
     - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions?tab=readme-ov-file)
     - [zsh-bat](https://github.com/fdellwing/zsh-bat)
     - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting?tab=readme-ov-file)