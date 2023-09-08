require "fileinto";
require "imap4flags";
require "vnd.proton.expire";

#  ___        _    _         
# | _ \___ __(_)__| |___ ___ 
# |   / -_|_-< / _` / -_) _ \
# |_|_\___/__/_\__,_\___\___/
if allof(
    address :is "from" "customer-service@resideo.com",
    anyof(
        header :matches "subject" "*Device Offline*",
        header :matches "subject" "*Camera Offline*",
        header :matches "subject" "*Sound detected*",
        header :matches "subject" "*Humidity*"
    )    
) {
    fileinto "Security/IoT";
    expire "day" "120";
    stop;
}



#   ___                  _      ___                  _ _        
#  / __|___ _ _  ___ _ _(_)__  / __| ___ __ _  _ _ _(_) |_ _  _ 
# | (_ / -_) ' \/ -_) '_| / _| \__ \/ -_) _| || | '_| |  _| || |
#  \___\___|_||_\___|_| |_\__| |___/\___\__|\_,_|_| |_|\__|\_, |
#                                                          |__/ 
if header :contains "subject" [
    "security alert",
    "security notification",
    "login",
    "sign in",
    "sign-in",
    "sign on",
    "sign-on",
    "email change",
    "password"
] {
    fileinto "Security";
    stop;
}
