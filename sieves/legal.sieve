require "fileinto";
require "vnd.proton.expire";

#  _                  _ ___ _    _     _    _ 
# | |   ___ __ _ __ _| / __| |_ (_)___| |__| |
# | |__/ -_) _` / _` | \__ \ ' \| / -_) / _` |
# |____\___\__, \__,_|_|___/_||_|_\___|_\__,_|
#           |___/                              
# LegalShield periodical adverts
if address :is "from" "cs@perkspot.com" {
    fileinto "Adverts";
    expire "day" "30";
}
