# In the event that the terminal is dumb, unset zle and
# act like a smart-ish terminal.
#
# Useful for editing over TRAMP within Emacs.
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

# Set up completion and colors
autoload -U compinit colors
compinit
colors

# Enable corrections
setopt correct

# Use ZSH autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh >/dev/null 2>&1

SAVEHIST=16384
HISTFILE=~/.zsh_history

function start_color {
	color_name="$1"
	bold="$2"

	if [ "$TERM" = "dumb" ];
	then
		echo ""

		return 0
	fi

	if [ "$bold" = "bold" ];
	then
		# Only return bolded colors.

		case $color_name in
		"red")
			echo "%{$fg_bold[red]%}"
			;;
		"blue")
			echo "%{$fg_bold[blue]%}"
			;;
		"green")
			echo "%{$fg_bold[green]%}"
			;;
		"cyan")
			echo "%{$fg_bold[cyan]%}"
			;;
		"yellow")
			echo "%{$fg_bold[yellow]%}"
			;;
		"magenta")
			echo "%{$fg_bold[magenta]%}"
			;;
		"white")
			echo "%{$fg_bold[white]%}"
			;;
		*)
			echo "%{$fg_bold[white]%}"
			;;
		esac
	else
		# Only return unbolded colors.

		case $color_name in
		"red")
			echo "%{$fg_no_bold[red]%}"
			;;
		"blue")
			echo "%{$fg_no_bold[blue]%}"
			;;
		"green")
			echo "%{$fg_no_bold[green]%}"
			;;
		"cyan")
			echo "%{$fg_no_bold[cyan]%}"
			;;
		"yellow")
			echo "%{$fg_no_bold[yellow]%}"
			;;
		"magenta")
			echo "%{$fg_no_bold[magenta]%}"
			;;
		"white")
			echo "%{$fg_no_bold[white]%}"
			;;
		*)
			echo "%{$fg_no_bold[white]%}"
			;;
		esac
	fi
}

function end_color {
	if [ "$TERM" = "dumb" ];
	then
		echo ""
		return 0
	fi

	echo "%{$reset_color%}"
}

alias ls="ls --color=auto"

machine_color="`start_color yellow unbold`"

prompt_dir="`start_color blue unbold`%~`end_color`"

function sed_escape_dirs {
	echo "$@" | sed 's/\//\\\//g'
}

function pwd_with_tilde {
	pwd | sed s/"`sed_escape_dirs $HOME`"/~/
}

function precmd {
	if [[ $? = "0" ]];
	then
		prompt_main_color="`start_color green unbold`"
	else
		prompt_main_color="`start_color red unbold`"
	fi

	# Git branch stuff from escherfan on Reddit
	if [ -n ${branch} ];
	then
		branch=`git rev-parse --abbrev-ref HEAD 2> /dev/null`

		if [[ "$(git status 2> /dev/null | tail -n1)" == "nothing to commit (working directory clean)" ||
						"$(git status 2> /dev/null | tail -n1)" == "nothing to commit, working directory clean" ||
						"$(git status 2> /dev/null | tail -n1)" == "nothing to commit, working tree clean" ]];
		then
			dirty="1"
		else
			dirty="0"
		fi

		if [[ "$dirty" = "0" ]];
		then
			prefix="g:`start_color red unbold`"
			suffix=""
		else
			prefix="g:`start_color green unbold`"
			suffix=""
		fi

		if [ $branch ];
		then
			branch=" ${prefix}$branch${suffix}`end_color`";
		fi
	else
		branch="";
	fi

	prompt_ssh=""

	if env | grep -q "^SSH_CLIENT\=";
	then
		prompt_ssh="`start_color green unbold``whoami``end_color`@`start_color yellow unbold``hostname``end_color`:"
	fi

	if [ `pwd_with_tilde | wc -c` -lt "35" ];
	then
		PROMPT=" $prompt_ssh$prompt_dir$branch \$ "
	else
		PS1=" $prompt_ssh$prompt_dir$branch \$ "
	fi
}

# Runs the previous command with sudo
function sudoit { sudo $history[$[HISTCMD-1]] }

# A function to quickly dump the contents of a file.
function lf {
	if [ -f $1 ];
	then
		cat $1
	elif [ -d $1 ];
	then
		ls $1
	else;
			echo "$1 passes neither \"test -f\" nor \"test -d\", so not a file or directory."
	fi
}

[ -e "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"

# added by travis gem
[ -f "$HOME/.travis/travis.sh" ] && source $HOME/.travis/travis.sh
