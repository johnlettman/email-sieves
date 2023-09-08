require "fileinto";
require "vnd.proton.expire";

#  ___ _    _              ___     _         _   _  __ _    
# | __(_)__| |_  ___ _ _  / __| __(_)___ _ _| |_(_)/ _(_)__ 
# | _|| (_-< ' \/ -_) '_| \__ \/ _| / -_) ' \  _| |  _| / _|
# |_| |_/__/_||_\___|_|   |___/\__|_\___|_||_\__|_|_| |_\__|
if address :is "from" "info@email.fishersci.com" {
    fileinto "Adverts";
    expire "day" "120";
    stop;
}

#    _       _       ____             
#   /_\ _  _| |_ ___|_  /___ _ _  ___ 
#  / _ \ || |  _/ _ \/ // _ \ ' \/ -_)
# /_/ \_\_,_|\__\___/___\___/_||_\___|
if address :is "from" "autozone@em.autozone.com" {
    fileinto "Adverts";
    expire "day" "30";
    stop;
}

#  _  _     _    _         _  ___           
# | || |___| |__| |__ _  _| |/ (_)_ _  __ _ 
# | __ / _ \ '_ \ '_ \ || | ' <| | ' \/ _` |
# |_||_\___/_.__/_.__/\_, |_|\_\_|_||_\__, |
#                     |__/            |___/ 
if address :is "from" "no_reply@hobbyking.com" {
    if header :matches "subject" "*Shipment*for Order*" {
        fileinto "Shipping";
        fileinto "Order Shipped"; # tag
    }
    if header :matches "subject" "*New Order*" {
        fileinto "Orders";
        fileinto "Order Confirmed"; # tag
    }

    stop;
}

#  ___            _             
# |   \ ___ _ __ (_)_ _  ___ ___
# | |) / _ \ '  \| | ' \/ _ (_-<
# |___/\___/_|_|_|_|_||_\___/__/
if address :domain :matches "from" "*offers.dominos.com" {
    discard;
}

#  _  _                          
# | \| |_____ __ _____ __ _ __ _ 
# | .` / -_) V  V / -_) _` / _` |
# |_|\_\___|\_/\_/\___\__, \__, |
#                     |___/|___/ 
if address :domain :is "from" "promo.newegg.com" {
    fileinto "Adverts";
    expire "day" "30";
    stop;
}

#  ___            _                    ___               _      
# |   \ _  _ _ _ | |_  __ _ _ __  ___ / __|_ __  ___ _ _| |_ ___
# | |) | || | ' \| ' \/ _` | '  \(_-< \__ \ '_ \/ _ \ '_|  _(_-<
# |___/ \_,_|_||_|_||_\__,_|_|_|_/__/ |___/ .__/\___/_|  \__/__/
#                                         |_|                   
if address :is "from" "no-reply@dunhamssports-email.com" {
    fileinto "Adverts";

    # Dunhams adverts appear only relevant to a 1-2 week period.
    expire "day" "15";
    stop;
}

#  ___ _____ ___    ___                   
# | __|_   _/ __|  / __|_ _ ___ _  _ _ __ 
# | _|  | | \__ \ | (_ | '_/ _ \ || | '_ \
# |___| |_| |___/  \___|_| \___/\_,_| .__/
#                                   |_|   
if address :is "from" "info@etsgroup.us" {
    fileinto  "Adverts";
    expire "day" "30";
    stop;
}

if address :is "from" "sales@etsgroup.us" {
    if header :matches "subject" "your order has shipped" {
        fileinto "Shipping";
        fileinto "Order Shipped"; # tag
        stop;
    }
    elsif header :matches "subject" "*order confirmation*" {
        fileinto "Orders";
        fileinto "Order Confirmed"; # tag
        stop;
    }
}

#  __  __   _   ___ 
# |  \/  | /_\ | __|
# | |\/| |/ _ \| _| 
# |_|  |_/_/ \_\_|  
if address :is "from" "admin@maf-arms.com" {
    if header :is "subject" "Your MAF Corp. order has been received!" {
        fileinto "Orders";
        fileinto "Order Confirmed"; # tag
        stop;
    }
    else {
        fileinto "Adverts/MAF Corp";
        expire "day" "120";
        stop;
    }
}

if header :is "subject" "Your order from MAF Corp is shipping" {
    fileinto "Shipping";
    fileinto "Order Shipped"; # tag
    stop;
}

#  ___ _      _   _    _     
# | _ (_)_ __| |_(_)__| |___ 
# |   / | '_ \  _| / _` / -_)
# |_|_\_| .__/\__|_\__,_\___|
#       |_|                  
if address :is "from" "RiptideRails@riptiderails.com" {
    fileinto "Adverts/Riptide";
    expire "day" "120";
    stop;
}

#  _  __                             _     ___ _               
# | |/ /___ _ __  _ __  __ _ _ _  __| |___/ __| |_ ___ _ _ ___ 
# | ' </ _ \ '  \| '  \/ _` | ' \/ _` / _ \__ \  _/ _ \ '_/ -_)
# |_|\_\___/_|_|_|_|_|_\__,_|_||_\__,_\___/___/\__\___/_| \___|
if address :is "from" "help@kommandostore.com" {
    if header :matches "subject" "*order*is on the way*" {
        fileinto "Shipping";
        fileinto "Order Shipped"; # tag
    }
    elsif header :matches "subject" ["gorka update*", "*gorkas are*"] {
        fileinto "Orders";
        fileinto "Order Update"; # tag
    }
    else {
        fileinto "Adverts";
    }

    stop;
}

#      ___            
#  ___| _ ) __ _ _  _ 
# / -_) _ \/ _` | || |
# \___|___/\__,_|\_, |
#                |__/ 
if address :domain :matches "from" "*deals.ebay.com" {
    fileinto "Adverts/eBay";

    # eBay sends these adverts FREQUENTLY.
    expire "day" "15";
    stop;
}
elsif address :is "from" "ebay@ebay.com" {
    if header :matches "subject" "order confirmed:*" {
        fileinto "Orders";
        fileinto "Order Confirmed"; # tag
        stop;
    }

}
