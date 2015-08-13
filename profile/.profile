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
fi

export PATH
