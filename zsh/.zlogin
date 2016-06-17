# Source RVM.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if [ -x ~/.zash_hooks/login ];
then
  ~/.zash_hooks/login
fi
