##################################################################################
# Collection of custom aliases that you might not want in your general ~/.bashrc #
# Is sourced by ~/.bashrc                                                        #
##################################################################################

alias pls='sudo "$BASH" -c "$(history -p !!)"' # Run the previous command as su
alias dns='systemctl restart systemd-resolved.service' # Restart DNS service

##################################################################################
# Source any additional scripts you might use (these are stored in ~/.rc/)       #
##################################################################################
source ~/.rc/*

