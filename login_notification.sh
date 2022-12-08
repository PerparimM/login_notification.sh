#!/bin/bash

# Set up email address to send notifications to
EMAIL_ADDRESS=user@example.com

# Set up log file location
LOG_FILE=/var/log/auth.log

# Watch for login and logout events in the log file
tail -f $LOG_FILE | while read line; do
  # Send email when a user logs in
  if echo $line | grep -q "session opened for user"; then
    user=$(echo $line | awk '{print $11}')
    host=$(echo $line | awk '{print $14}')
    echo "User $user logged in to $host" | mail -s "Login Notification" $EMAIL_ADDRESS
  fi
  
  # Send email when a user logs out
  if echo $line | grep -q "session closed for user"; then
    user=$(echo $line | awk '{print $11}')
    host=$(echo $line | awk '{print $14}')
    echo "User $user logged out of $host" | mail -s "Logout Notification" $EMAIL_ADDRESS
  fi
done
