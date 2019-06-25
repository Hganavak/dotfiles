##################################################################################
# Collection of custom aliases that you might not want in your general ~/.bashrc #
# Is sourced by ~/.bashrc                                                        #
##################################################################################

alias pls='sudo "$BASH" -c "$(history -p !!)"' # Run the previous command as su
alias dns='systemctl restart systemd-resolved.service' # Restart DNS service
alias mac='sudo macchanger -r wlp2s0' # Assign random MAC address
alias douche='du -sch */ * | sort -h' # List all folders with their total sizes
alias 30=$'wget -q https://raw.githubusercontent.com/30-seconds/30-seconds-of-code/master/README.md -O - | awk -vn=$(shuf -i 14-360 -n 1) \'/###/ {i++;k=1}; i==n && k==1 {print}; /<\/details>/ {k=0}\' | awk \'$0 !~ "```|details"\' | sed \"s/<summary.*$Examples/Examples:/g\" | sed \"s/### //g\" | sed \"s/\`//g\" | head -n-1'

# Git: Commit and push
function gcp() {
	git commit -am "$1" && git push
}

#####################################################################################################
# Source any additional scripts you might use (these are stored in ~/.rc/functions-aliases/*)       #
#####################################################################################################
for f in ~/.rc/functions-aliases/*; do source $f; done
