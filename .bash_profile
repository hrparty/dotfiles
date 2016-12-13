# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

export EDITOR="vim"

# autocomplete options
bind '"\t":menu-complete'
bind "set completion-ignore-case on"

# load bash the bash prompt settings
source ~/.bash_prompt

# load git autocomplete
source ~/.git-completion.bash

# load extra settings that are not commited to source control
[ -r ~/.extra ] && [ -f ~/.extra ] && source ~/.extra;
[ -r ~/.path ] && [ -f ~/.path ] && source ~/.path;

# convenience shortcuts
alias shellrefresh=". ~/.bash_profile"
alias ..="cd .."
alias ll="ls -l"
alias la="ls -la"

# pretty prints a folder structure out of current folder and its subdirectories
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# kill core audio, fixes the problem when you can't connect to airport via airplay
alias killaudio="sudo pkill coreaudiod"

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Always use color output for `ls`
alias ls="command ls -G"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Cleans up untagged docker images
alias dockerclean="docker rmi $(docker images -q -f dangling=true)"

# enable shims and autocompletion for pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@"
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}"
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Generates a random string, and puts it into the clipboard
genpasswd() {
	openssl rand -base64 32 | tr -d '\n' | pbcopy
}
