require "fileinto";

# Process bounce notifications
if envelope :matches "from" ["MAILER-DAEMON", "MAILER-DAEMON@*", "postmaster@*"] {
    fileinto "Inbox/Bounces";
}
