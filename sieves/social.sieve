require "fileinto";
require "vnd.proton.expire";

#  ___         _                            
# |_ _|_ _  __| |_ __ _ __ _ _ _ __ _ _ __  
#  | || ' \(_-<  _/ _` / _` | '_/ _` | '  \ 
# |___|_||_/__/\__\__,_\__, |_| \__,_|_|_|_|
#                      |___/                
if address :is "from" "no-reply@mail.instagram.com" {
    fileinto "Notifications/Instagram";
    expire "day" "30";
    stop;
}

#  ___            _              _   
# | __|_ _ __ ___| |__  ___  ___| |__
# | _/ _` / _/ -_) '_ \/ _ \/ _ \ / /
# |_|\__,_\__\___|_.__/\___/\___/_\_\
if address :is "from" "security@facebookmail.com" {
    fileinto "Security";
    stop;
}
elsif address :domain :is "facebookmail.com" {
    if address :is "from" "messages@facebookmail.com" {
        fileinto "Messages";
        fileinto "Direct Message"; # tag
        expire "day" "7";
        stop;
    }
    elsif address :is "from" "friends@facebookmail.com" {
        fileinto "Friend Request"; # tag
        expire "day" "30";
    }
    elsif address :is "from" "birthdays@facebookmail.com" {
        fileinto "Birthday"; # tag
        expire "day" "3";
    }
    else {
        expire "day" "30";
    }

    fileinto "Notifications/Facebook";
    stop;
}

#  _    _      _          _ ___      
# | |  (_)_ _ | |_____ __| |_ _|_ _  
# | |__| | ' \| / / -_) _` || || ' \ 
# |____|_|_||_|_\_\___\__,_|___|_||_|
if address :is "from" "hit-reply@linkedin.com" {
    fileinto "Messages";
    fileinto "Direct Message"; # tag
    expire "day" "30";
    stop;
}
elsif address :is "from" "messages-noreply@linkedin.com" {
    # LinkedIn often sends updates about folks' profile updates.
    fileinto "Career/People";
    expire "day" "10";
    stop;
}
elsif address :is "from" "jobs-listings@linkedin.com" {
    # Not actively looking :) but I get sent these anyways.
    fileinto "Career/Job Listings";
    expire "day" "120";
    stop;
}
elsif address :is "from" "groups-noreply@linkedin.com" {
    fileinto "Career/Groups";
    expire "day" "120";
    stop;
}



