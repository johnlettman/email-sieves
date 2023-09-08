require "fileinto";
require "imap4flags";
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

#  ___ _ _   _    _ _   
# | __(_) |_| |__(_) |_ 
# | _|| |  _| '_ \ |  _|
# |_| |_|\__|_.__/_|\__|
if address :is "from" "messages-noreply@fitbit.com" {
    fileinto "Notifications/Fitbit";
    expire "day" "30";
    stop;
}

#   ___ _ _   _  _      _    
#  / __(_) |_| || |_  _| |__ 
# | (_ | |  _| __ | || | '_ \
#  \___|_|\__|_||_|\_,_|_.__/
if allof(
    address :is "from" "notifications@github.com",
    address :is "cc" [
        "mention@noreply.github.com",
        "team_mention@noreply.github.com"
    ]
) {
    fileinto "Notifications/GitHub";
    fileinto "Mention"; # set the Mention label
    expire "day" "90";
    stop;
}
elsif address :is "cc" "your_activity@noreply.github.com" {
    addflag "\\Seen";
    fileinto "Notifications/GitHub";
    expire "day" "15";
    stop;
}
elsif anyof(
    address :is "cc" "assign@noreply.github.com",
    address :is "cc" "review_requested@noreply.github.com"
) {
    fileinto "Notifications/GitHub";
    fileinto "Review Request"; # set the Review Request label
    expire "day" "90";
    stop;
}
elsif anyof(
    address :is "cc" "comment@noreply.github.com",
    address :is "cc" "milestone@noreply.github.com",
    address :is "cc" "push@noreply.github.com",
    address :is "cc" "state_change@noreply.github.com"
) {
    fileinto "Notifications/GitHub";
    expire "day" "30";
    stop;
}
