export ZSH=$HOME/.oh-my-zsh
export DOTFILES=$HOME/dotfiles

export PROJECTS=~/Projects

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

ZSH_THEME="robbyrussell"

# all of our zsh files
typeset -U config_files
config_files=($DOTFILES/**/*.zsh)

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
  source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

unset config_files

# Direnv hook
eval "$(direnv hook zsh)"

# Boxen stuff
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
