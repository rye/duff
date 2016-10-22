autoload -U compinit colors
compinit
colors

alias ls="ls --color=auto -A"

# Find the directory which holds this file
zsh_directory=$(dirname $(readlink -f ~/.zshrc))

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

alias ls="ls --color=auto -A"

PATH=$HOME/.local/bin:$PATH

machine_color="`start_color yellow unbold`"

prompt_dir="`start_color blue unbold`%~`end_color`"

function sed_escape_dirs {
	echo "$@" | sed 's/\//\\\//g'
}

function pwd_with_tilde {
	pwd | sed s/"`sed_escape_dirs $HOME`"/~/
}

function precmd {	
	if [[ "$TERM" = "dumb" ]];
	then
		PROMPT="> "
		PS1="> "
	else
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
				prefix="`start_color red unbold`("
				suffix=")"
			else
				prefix="`start_color green unbold`("
				suffix=")"
			fi

			if [ $branch ];
			then
				branch=" ${prefix}$branch${suffix}`end_color`";
			fi
		else
			branch="";
		fi

		prompt_ssh=""

		if env | grep -q ^SSH_CLIENT=;
		then
			prompt_ssh="`start_color green unbold``whoami``end_color`@`start_color yellow unbold``hostname``end_color`:"
		fi

		if [ `pwd_with_tilde | wc -c` -lt "35" ];
		then
			PROMPT=" $prompt_ssh$prompt_dir$branch \$ "
		else
			PS1=" $prompt_ssh$prompt_dir$branch \$ "
		fi
	fi
}

function red {
	return 1
}

function green {
	return 0
}

function sudoit {
	sudo $history[$[HISTCMD-1]]
}

setopt correct

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

if [ -d $HOME/Software/apache-ant-1.9.4/bin ];
then
	PATH="$PATH:$HOME/Software/apache-ant-1.9.4/bin"
fi

# added by travis gem
[ -f /Users/kristofer/.travis/travis.sh ] && source /Users/kristofer/.travis/travis.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
