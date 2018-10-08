#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
if test -e $HOME/.profile_private; then
    source $HOME/.profile_private
fi
source $HOME/.profile

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/manas/install/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/manas/install/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/manas/install/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/manas/install/google-cloud-sdk/completion.zsh.inc'; fi

