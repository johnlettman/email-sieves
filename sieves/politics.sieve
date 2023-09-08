require "fileinto";
require "imap4flags";
require "vnd.proton.expire";



# Senator Chris Dush -- hyper-local updates.
if address :is "cdush@pasen.gov" {
    fileinto "Politics/Pennsylvania";
    fileinto "State Senate"; # tag
    stop;
}


#  __  __              ___       
# |  \/  |_____ _____ / _ \ _ _  
# | |\/| / _ \ V / -_) (_) | ' \ 
# |_|  |_\___/\_/\___|\___/|_||_|
# Only discard MoveOn adverts.
if address :domain :is "list.moveon.org" {
    discard;
}

#   ___           ___         
#  / _ \ _  _ _ _| _ \_____ __
# | (_) | || | '_|   / -_) V /
#  \___/ \_,_|_| |_|_\___|\_/
# Progressive-leaning advertiser.
if address :domain :is "ourrevolution.com" {
    discard;
}

#   ___            _     
#  / __|_ _ ___ __| |___ 
# | (__| '_/ -_) _` / _ \
#  \___|_| \___\__,_\___/
# Progressive-leaning advertiser.
if address :domain :is "credomobile.com" {
    discard;
}


