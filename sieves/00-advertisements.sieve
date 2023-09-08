require "fileinto";
require "vnd.proton.expire";















if exists "list-unsubscribe" {

    if address :domain :matches "from" "dunhamssports*" {
        fileinto "Adverts/Dunhams";
        stop;
    }

    if address :is "from" "etsgroup.us" {
        fileinto "Adverts/ETS";
        stop;
    }




}
