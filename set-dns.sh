#!/bin/bash
# call script as:
# ./set-dns.sh host.dns.name. SHARED_SECRET_1 "abc123.execute-api.us-west-2.amazonaws.com/prod"

# If the script is called with no arguments, show an instructional error message.
if [ $# -eq 0 ]
    then
    echo 'The script requires hostname and shared secret arguments.'
    echo "ie  $0 host.dns.name. 1.2.3.4 sharedsecret \"abc123.execute-api.us-west-2.amazonaws.com/prod\""
    exit
fi

# Set variables based on input arguments
myHostname=$1
myIP=$2
mySharedSecret=$3
myAPIURL=$4
# Build the hashed token
myHash=`echo -n $myIP$myHostname$mySharedSecret | shasum -a 256 | awk '{print $1}'`
# Call the API in set mode to update Route 53
curl -q -s "https://$myAPIURL?mode=set&hostname=$myHostname&ip=$myIP&hash=$myHash"
echo
