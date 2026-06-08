#!/bin/bash

REPORT_FILE="network_report.txt"

# Start report

echo "======================================" > $REPORT_FILE
echo "      NETWORK HEALTH CHECK REPORT     " >> $REPORT_FILE
echo "======================================" >> $REPORT_FILE
echo "" >> $REPORT_FILE

# 1. Server Information

echo "SERVER INFORMATION" | tee -a $REPORT_FILE
echo "Hostname: $(hostname)" | tee -a $REPORT_FILE
echo "Current User: $(whoami)" | tee -a $REPORT_FILE
echo "Date and Time: $(date)" | tee -a $REPORT_FILE
echo "" | tee -a $REPORT_FILE

# 2. Network Information

echo "NETWORK INFORMATION" | tee -a $REPORT_FILE

IP_ADDRESS=$(hostname -I | awk '{print $1}')
echo "IP Address: $IP_ADDRESS" | tee -a $REPORT_FILE

DEFAULT_GATEWAY=$(ip route | grep default | awk '{print $3}')
echo "Default Gateway: $DEFAULT_GATEWAY" | tee -a $REPORT_FILE

DNS_SERVER=$(grep "nameserver" /etc/resolv.conf | awk '{print $2}' | head -1)
echo "DNS Server: $DNS_SERVER" | tee -a $REPORT_FILE
echo "" | tee -a $REPORT_FILE

# 3. Internet Connectivity Check

echo "INTERNET CONNECTIVITY" | tee -a $REPORT_FILE

if ping -c 2 8.8.8.8 > /dev/null 2>&1; then
echo "Internet Connectivity: UP" | tee -a $REPORT_FILE
else
echo "Internet Connectivity: DOWN" | tee -a $REPORT_FILE
fi

echo "" | tee -a $REPORT_FILE

# 4. DNS Resolution Check

echo "DNS RESOLUTION" | tee -a $REPORT_FILE

if nslookup google.com > /dev/null 2>&1; then
echo "DNS Resolution: WORKING" | tee -a $REPORT_FILE
else
echo "DNS Resolution: FAILED" | tee -a $REPORT_FILE
fi

echo "" | tee -a $REPORT_FILE

# 5. Website Availability Check

echo "WEBSITE AVAILABILITY" | tee -a $REPORT_FILE

for site in google.com github.com amazon.com
do
if ping -c 2 $site > /dev/null 2>&1; then
echo "$site : UP" | tee -a $REPORT_FILE
else
echo "$site : DOWN" | tee -a $REPORT_FILE
fi
done

echo "" | tee -a $REPORT_FILE
echo "Report saved to $REPORT_FILE"
