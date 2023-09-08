require "fileinto";
require "vnd.proton.expire";

#  _  _            ___      __    _ _     _   
# | \| |___ _ _ __| \ \    / /_ _| | |___| |_ 
# | .` / -_) '_/ _` |\ \/\/ / _` | | / -_)  _|
# |_|\_\___|_| \__,_| \_/\_/\__,_|_|_\___|\__|
if address :is "from" "nerdwallet@mail.nerdwallet.com" {
    fileinto "Adverts";
    expire "day" "120";
    stop;
}

#  ___         _       _   _                      
# | _ \___  __| |_____| |_| |   ___  __ _ _ _  ___
# |   / _ \/ _| / / -_)  _| |__/ _ \/ _` | ' \(_-<
# |_|_\___/\__|_\_\___|\__|____\___/\__,_|_||_/__/
if address :is "from" [
    "support@e.rocketloans.com",
    "QuickenLoans@e.QuickenLoans.com"
 ] {
    fileinto "Adverts";
    expire "day" "10";
    stop;
}
