require "fileinto";
require "vnd.proton.expire";

#  ___          _ _           
# | _ \___ __ _| | |_ ___ _ _ 
# |   / -_) _` | |  _/ _ \ '_|
# |_|_\___\__,_|_|\__\___/_|  
if address :is "from" "email@consumer.realtor.com" {
    fileinto "Adverts";
    expire "day" "30";
    stop;
}
