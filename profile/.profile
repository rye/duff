[ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/include" ] && [[ ":$C_INCLUDE_PATH:" != *":$HOME/.local/include:"* ]] && C_INCLUDE_PATH="${C_INCLUDE_PATH:+"$C_INCLUDE_PATH:"}$HOME/.local/include"
[ -d "$HOME/.local/include" ] && [[ ":$CPLUS_INCLUDE_PATH:" != *":$HOME/.local/include:"* ]] && CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH:+"$CPLUS_INCLUDE_PATH:"}$HOME/.local/include"
[ -d "$HOME/.local/lib" ] && [[ ":$LIBRARY_PATH:" != *":$HOME/.local/lib:"* ]] && LIBRARY_PATH="${LIBRARY_PATH:+"$LIBRARY_PATH:"}$HOME/.local/lib"
[ -d "$HOME/.local/lib/pkgconfig" ] && [[ ":$PKG_CONFIG_PATH:" != *":$HOME/.local/lib/pkgconfig:"* ]] && PKG_CONFIG_PATH="${PKG_CONFIG_PATH:+"$PKG_CONFIG_PATH:"}$HOME/.local/lib/pkgconfig"

[ -d "/usr/local/heroku/bin" ] && [[ ":$PATH:" != *":/usr/local/heroku/bin:"* ]] && PATH="/usr/local/heroku/bin:$PATH"

[ -L "$HOME/.local/java/latest" ] && JAVA_HOME="$HOME/.local/java/latest" && PATH="$HOME/.local/java/latest/bin:$PATH"
[ -L "$HOME/.local/ant/latest" ] && ANT_HOME="$HOME/.local/ant/latest" && PATH="$HOME/.local/ant/latest/bin:$PATH"

[ -d "$HOME/Software/apache-ant-1.9.4/bin" ] && PATH="$HOME/Software/apache-ant-1.9.4/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"

[ -d "/Volumes/Tritium/Development/Android" ] && ANDROID_HOME="/Volumes/Tritium/Development/Android/sdk" && export ANDROID_HOME
[ -d "$ANDROID_HOME/tools" ] && PATH="$ANDROID_HOME/tools:$PATH"
[ -d "$ANDROID_HOME/platform-tools" ] && PATH="$ANDROID_HOME/platform-tools:$PATH"

# Do some magic to determine if we're a Mac OSX machine or nah.
# NOTE: Requires GNU coreutils to be installed via Homebrew to properly get shit going.
if which guname >/dev/null 2>&1;
then
	if [ "`guname -o`" = "Darwin" ];
	then
		PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
		PATH="$(brew --prefix ruby)/bin:$PATH"
		PATH="/opt/local/bin:/opt/local/sbin:$PATH"
		PATH="/usr/local/sbin:$PATH"
	fi
fi

which ruby >/dev/null 2>&1 && which gem >/dev/null 2>&1 && PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"

[ -f "$HOME/.local/.profile" ] && source $HOME/.local/.profile

if [ -z ${TERM+__nilstring__} ] || [[ $TERM == "dumb" ]];
then
    echo "TERM not set or dumb..."
else
    # In order for gpg to find gpg-agent, gpg-agent must be running, and there must be an env
    # variable pointing GPG to the gpg-agent socket. This little script will either start
    # gpg-agent or set up the GPG_AGENT_INFO variable if it's already running.
    if which gpg >/dev/null 2>&1 && which gpg-agent >/dev/null 2>&1;
    then
	    if [ -n "$(pgrep gpg-agent)" ];
	    then
		    echo "[gpg] will connect to existing GPG daemon"
	    else
		    echo "[gpg] starting new GPG daemon"
		    eval $(gpg-agent --daemon)
	    fi

	    GPG_TTY=$(tty)
    else
	    echo "[gpg] GPG Agent or GPG not present; shirking responsibilities"
    fi
fi



export PATH
