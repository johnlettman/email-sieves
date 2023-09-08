require "fileinto";
require "vnd.proton.expire";


if header :contains "subject" [
    "out for delivery",
    "scheduled for delivery"
]
{
    fileinto "Orders/Out for Delivery";
    stop;
}

if header :contains "subject" [
    "track your order",
    "item(s) are on the way",
    "items are on the way",
    "is on the way"
]
{
    fileinto "Orders/Tracking";
    stop;
}

if anyof(
    header :contains "subject" ["order has arrived", "has been delivered"]
)
{
    fileinto "Orders/Delivered";
    stop;
}
