# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your ohh-my-zsh installation.
export ZSH="/Users/sam/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"
#ZSH_THEME="amuse"
#ZSH_THEME="avit"
#ZSH_THEME="bira"
#ZSH_THEME="clean"
#ZSH_THEME="half-life"
#ZSH_THEME="jonathan"
#ZSH_THEME="wedisagree"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
prompt_context(){} # Hide user@hostname when your logged in as self

#code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;}

# Custom Aliases/functions
unalias gcp; # From zsh
function gcp() {
#	git commit -am "$1" && git push
	git add --all
	git commit -m "$1"
	git push
}

# gcp + merge into sandbox and push
function gcps() {
	gcp "$1"
	branch=$(git symbolic-ref --short -q HEAD)
	git checkout sandbox
	git pull
	git merge $branch
	git push
	git checkout $branch
}

# Get a list of TODO:s
alias todo="grep -Rni 'TODO:' . --exclude-dir=node_modules -B 3 -A 3"

# CeR-GraphQL env variables
#export CONTENTFUL_ACCESS_TOKEN=hWFTaut-fsZZ7gk8lmCHxY_OohuOO9wJziENjstWghk
#export CONTENTFUL_SPACE_ID=vbuxn5csp0ik
#export COGNITO_USER_POOL=ap-southeast-2_pgErjyL4O
#export COGNITO_REGION=ap-southeast-2
#export CONTENTFUL_MANAGEMENT_TOKEN=CFPAT-60F-yz6WQR6YD0aUaWX96SS2RK0PQLvJRO0_AheyC9M

 function idea() {
     cd ~/ideas # cd to idea-log repo directory
     echo -e $(date) "\n$1\n" >> idea-log # Timestamp + add idea to the idea-log file
     git commit -am "$1" --quiet # Silently commit (commit msg=idea) the change
     git push --quiet # Silently push the idea
     cd - > /dev/null # Silently cd back to the previous working directory
     echo -e "Idea added"
 }

 function ideas() {
     cd ~/ideas # cd to idea-log repo directory
     git pull --quiet # Pull any new ideas that have been added
     cat idea-log | grep -i "$1" # Read the idea log (you can search too with grep)
     cd - > /dev/null # Silently cd back to the previous working directory
 }


function ahoy() {
	echo "Ahoy! Clearing port ${1} for ye', Cap'n!"
	lsof -ti:${1} | xargs kill
}

function ngmc() {
	ng g m $1 --routing && ng g c $1/$1 --module=$1/$1 --flat 
}

function _accept-line() {
    if [[ $BUFFER == "." ]]; then
        BUFFER="source ~/.zshrc"
    fi
    zle .accept-line
} 

zle -N accept-line _accept-line

# Whatup CeR!
#function sup() {
#    case $1 in
#	"ci"|"cerci") ssh skav012@cerciprd01.its.auckland.ac.nz
#	      ;;
#	"reg"|"registry") ssh -t skav012@cerciprd01.its.auckland.ac.nz '
#			  for repo in $(curl --silent localhost:5000/v2/_catalog | jq -r .repositories[]); do
#			      curl --silent localhost:5000/v2/${repo}/tags/list | jq .;
#			  done;'
#		;;
#	"graph") cd ~/Documents/contentful-graph/contentful-graph && source tokens && contentful-graph | dot -Tpng > model.png && xdg-open model.png
#		;;
#	"stack") cd ~/Documents/research-hub-deploy/ && ./hubby-local up -d && cd --
#		;;
#	"dev") gnome-terminal --window-with-profile=SSH -- ssh skav012@cerhubpdev02.its.auckland.ac.nz
#	      ;;
#	"test") gnome-terminal --window-with-profile=SSH -- ssh skav012@cerhubptest01.its.auckland.ac.nz
#	      ;;
#	"prod") gnome-terminal --window-with-profile=SSH -- ssh skav012@rhubprd01.its.auckland.ac.nz
#	      ;;
#	"sam")  gnome-terminal --window-with-profile=SSH -- ssh skav012@sam.cer.auckland.ac.nz
#	      ;;
#	"figshare")  ssh skav012@figshare-hr.its.auckland.ac.nz
#	      ;;
#	"eres")  ssh skav012@cli.cer.auckland.ac.nz
#	      ;;
#	"jenkins") ssh -L 8080:localhost:8080 skav012@cerciprd01.its.auckland.ac.nz -fN
#		xdg-open 'http://localhost:8080' > /dev/null 2>&1 & disown
#	      ;;
#	"isolation") sudo pkill ssh 
#	      ;;
#	*) echo "Usage: sup [hub/web/api/sc/rb/hg] [dev/test/prod/jenkins/reg/sam] [eres/figshare] [isolation] [stack] [screens]"
#              ;;
#    esac
#}



# @!#@!@$#@$#** Boom @!#@!@$#@$#** 

# Function to quiet the output of a cmd unless it fails 
# Use: quiet rm something || echo "custom message"
quiet() {
    "$@" > /dev/null 2>&1
}

function boom() {
        echo "Boom! Creating Git & GitHub repo. Please wait..."
        # If a param is passed, create a dir with that name and cd to it
        if [ $1 ] ; then
                quiet mkdir $1 && cd $1
                echo "Created folder $1"
        fi
        # Create README file if it doesn't already exist with directory name
        if [ ! -f README.md ] ; then
                quiet echo "# ${PWD##*/}" > README.md
                echo "Generated a README.md file"
        fi
        git init
        git add .
        git commit -m "Initial commit"
        #quiet gh create -p # -p create private GitHub repo
        gh repo create ${PWD##*/} --private --source=. --remote=origin
	# gh repo create ${PWD##*/} --private -y
        git push -u origin main
        echo "Boom! Your repo is live: $(git config --get remote.origin.url)" # Output repo URL
}

# @!#@!@$#@ END Boom @!#@!@$#@$#** 

alias cnpmi='rm -rf node_modules/; rm package-lock.json; npm i'
#alias hubby='cd /Users/skav012/hub-stack/research-hub-web; ahoy 4000; npm run qdev'
#alias gql='cd ~/hub-stack/cer-graphql; npm run dev'

# Add all files, commit to feature branch, push feature branch, checkout your sandbox-, pull, merge in your feature branch, push, switch back to your feature
#function deploy() {
#        git add --all
#        git commit -m "$1"
#        git push
#        branch=$(git symbolic-ref --short -q HEAD)
#        git checkout sandbox-sam # <----------------------- Change this to yours
#        git pull
#        git merge $branch
#        git push
#        git checkout $branch
#}

# GCD Implimentation
function deploy() {
	if [[ "$1" != "taupo"  &&  "$1" != "rotorua" &&  "$1" != "uat" && "$1" != "taupo2" && "$1" != "rotorua2" && "$1" != "uat2" ]]; then
		echo "Usage: deploy [taupo, rotorua, uat, taupo2, rotorua2, uat2]" && return;
	fi 

        branch=$(git symbolic-ref --short -q HEAD) # Current branch
	new_branch="${1}/${branch}" # New branch
	sep="\n==============================================================================================\n"

	echo "${sep}Deploying to: ${new_branch}...${sep}"

	# Check if branch is already known (either locally or remotely)
	existed_in_local=$(git branch --list "$new_branch")
	existed_in_remote=$(git ls-remote --heads origin "$new_branch")

	if [[ -z ${existed_in_remote} || -z ${existed_in_local} ]]; then # New branch
		echo "${sep}This feature has not been deployed to $1 before. Creating a new branch${sep}"
	        git checkout -b "$new_branch" 
	        git push -u origin "${1}/${branch}"
	else # Existing branch
		echo "${sep}This branch has been deployed before. Re-deploying to $new_branch${sep}"
	        git checkout "$new_branch" 
		git pull --ff-only # Check if there's been any updates to the existing branch
	        git merge $branch
		git push
	fi

        git checkout $branch
	echo "${sep}Deployed $branch to ${1}/${branch}\nYou are now back on $branch${sep}"
}

#alias search='. /Users/skav012/elastic/test-queries/search2.sh'
alias rec='asciinema rec'
alias sandbox"=export SCHEMA_PATH='https://rhubcpapi.sandbox.amazon.auckland.ac.nz/'; export BRANCH_NAME='sandbox'"
alias bashmon="nodemon -q $1 --exec '. $1'"
alias dog="highlight $1"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

export PATH=/usr/local/bin:$PATH

# ~~~~~~ Limelight Settings ~~~~~~ #
#SERVICE="limelight"
#if pgrep -x "$SERVICE" >/dev/null
#then
#       echo "$SERVICE is running"
#else
#	echo "$SERVICE stopped"
#	killall limelight &> /dev/null
#	limelight &> /dev/null &!
#	sleep 2
#	limelight -m config width            3
#	limelight -m config radius           3
#	limelight -m config placement        exterior
#	limelight -m config active_color     0x00FF0000
#	limelight -m config normal_color     0xffffffff
#fi
# ~~~~~~ Limelight Settings ~~~~~~ #


function hr() {
    autoload -U colors # black, red, green, yellow, blue, magenta, cyan, and white
    colors
    fg_color=${1:-blue} # change blue here if you want a different default
    printf "$fg[$fg_color]%0.s─$fg[default]" $(seq 1 $(tput cols))
}

export NODE_OPTIONS=--max_old_space_size=6144

# Sentry settings
export SENTRY_AUTH_TOKEN=51e52c0e726d4446af07100fd785c563445de73f0b4d4f7e927f82f638ff768c
export VAULT_TOKEN=s.AvizT14ltOrmXWuFqpXyI3u0.pl3bj
export GCD_DEV_PAT=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
export HISTTIMEFORMAT="%d/%m/%y %T "
#export PATH="/opt/homebrew/opt/node@16/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"


# Load Angular CLI autocompletion.
source <(ng completion script)


# Enable media keys
#launchctl load -w /System/Library/LaunchAgents/com.apple.rcd.plist


# React Native Android settings
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform:${PATH}"
alias adb="$HOME/Library/Android/sdk/platform-tools/adb"
export ANDROID_SDK_HOME="$ANDROID_HOME/.android"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export ANDROID_AVD_HOME="$ANDROID_HOME/.android/avd"

##### START ALIASES ####
alias n="npm run $1"
alias taupo="n fast-serve taupo -- -o"
alias rotorua="n fast-serve rotorua"
alias serve="n fast-serve"
alias scripts="cat package.json | jq .scripts"
alias repo="gh repo view --web"
alias mongo-start="mongod --config /opt/homebrew/etc/mongod.conf --fork"
alias mongo-stop="pkill mongod"
alias mongo-check="ps aux | grep -v grep | grep mongod"
alias potato="ls -ah"
alias npmci="rm -rf node_modules/; rm package-lock.json; npm i --legacy-peer-deps"
alias npmli="npm i --legacy-peer-deps"
alias clean="git clean -fd"
alias s="source ~/.zshrc"
alias v="vim ~/.zshrc"
alias ts='open "http://18.117.91.244:8111/agents/overview"'
alias oct='open "http://18.117.91.244:8112/"'
alias portal='cd ~/milford-portal-web'
alias dns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias pls="sudo $(history -p !!)"
alias rn="cd ~/milford-portal-mobile"
alias d="doppler run -- $1"
alias ds="doppler secrets"
alias dr="doppler run -- npm run $1"
alias douche="du -sch * | sort -h"
alias ngc="ng g c --standalone --inline-style --inline-template --flat --skip-tests $1"
alias play="launchctl load -w /System/Library/LaunchAgents/com.apple.rcd.plist"
alias ngfs="npm run ngf serve"
alias graph="git log --graph --decorate --oneline"
alias gs="git status"
alias gl="git log"
alias gd="git diff"
alias gc="git checkout $1"
alias rn="cd ~/milford-stack/milford-portal-mobile-react-native"
alias ffs="yarn && yarn pods && yarn start --reset-cache"
alias ffs2="yarn && yarn prebuild --clean && yarn ios"
alias ffs3="rm -rf node_modules/ && yarn && yarn pods && yarn start --reset-cache"
alias recent="git pull; git for-each-ref --sort=committerdate refs/heads refs/remotes --format='%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset)) %(authorname)'"
alias killsim="sudo killall -9 com.apple.CoreSimulator.CoreSimulatorService"
alias g.="git checkout -- ."

function search() {
	grep --color=always -n -A 3 -B 3 "$1" $(find . -type f)
}


# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$PATH:$(npm get prefix)/bin"
