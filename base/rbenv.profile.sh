export RBENV_ROOT="/usr/share/rbenv"
export RUBYOPT="$(echo $RUBYOPT|sed -e's/-rauto_gem//')"
