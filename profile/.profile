if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]];
then
	PATH="${PATH:+"$PATH:"}$HOME/.local/bin"
fi

if [ -d "$HOME/.local/include" ] && [[ ":$C_INCLUDE_PATH:" != *":$HOME/.local/include:"* ]];
then
	C_INCLUDE_PATH="${C_INCLUDE_PATH:+"$C_INCLUDE_PATH:"}$HOME/.local/include"
fi

if [ -d "$HOME/.local/include" ] && [[ ":$CPLUS_INCLUDE_PATH:" != *":$HOME/.local/include:"* ]];
then
	CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH:+"$CPLUS_INCLUDE_PATH:"}$HOME/.local/include"
fi

if [ -d "$HOME/.local/lib" ] && [[ ":$LIBRARY_PATH:" != *":$HOME/.local/lib:"* ]];
then
	LIBRARY_PATH="${LIBRARY_PATH:+"$LIBRARY_PATH:"}$HOME/.local/lib"
fi

if [ -d "$HOME/.local/lib/pkgconfig" ] && [[ ":$PKG_CONFIG_PATH:" != *":$HOME/.local/lib/pkgconfig:"* ]];
then
	PKG_CONFIG_PATH="${PKG_CONFIG_PATH:+"$PKG_CONFIG_PATH:"}$HOME/.local/lib/pkgconfig"
fi

if [ -L "$HOME/.local/java/latest" ];
then
	JAVA_HOME="$HOME/.local/java/latest"
	PATH="$HOME/.local/java/latest/bin:$PATH"
fi

if [ -L "$HOME/.local/ant/latest" ];
then
	ANT_HOME="$HOME/.local/ant/latest"
	PATH="$HOME/.local/ant/latest/bin:$PATH"
fi

# Do some magic to determine if we're a Mac OSX machine or nah.
# Note: requires Homebrew's "coreutils" package to be installed.
if [ "`guname -o`" = "Darwin" ];
then
	PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
	PATH="$(brew --prefix ruby)/bin:$PATH"
	PATH="/opt/local/bin:/opt/local/sbin:$PATH"
	PATH="/usr/local/sbin:$PATH"
fi

if [ -f "$HOME/.local/.profile" ];
then
	source $HOME/.local/.profile
fi

# In order for gpg to find gpg-agent, gpg-agent must be running, and there must be an env
# variable pointing GPG to the gpg-agent socket. This little script will either start
# gpg-agent or set up the GPG_AGENT_INFO variable if it's already running.
if [ -n "$(pgrep gpg-agent)" ];
then
	echo "[gpg] will connect to existing GPG daemon"
else
	echo "[gpg] starting new GPG daemon"
	eval $(gpg-agent --daemon)
fi

if [ -d "/usr/local/heroku/bin" ];
then
	PATH="/usr/local/heroku/bin:$PATH"
fi

export PATH
