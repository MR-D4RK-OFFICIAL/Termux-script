#!/bin/bash

# Log file location
log_file="activity_log.txt"

# Function to log user activity
log_activity() {
    echo "$(date) - $1" >> $log_file
}

# Welcome Message
echo "Welcome to Termux API Script!"
echo "Please select an option from the list below:"

# Display Menu
PS3="Enter your choice: "
select choice in "Take Photo" "Get Location" "Send SMS" "Battery Status" "Flashlight On" "Flashlight Off" "Send Notification" "Admin Panel" "Exit"
do
    case $choice in
        "Take Photo")
            echo "Taking photo..."
            termux-camera-photo photo.jpg
            log_activity "Took photo and saved as 'photo.jpg'."
            echo "Photo taken and saved as 'photo.jpg'."
            ;;
        
        "Get Location")
            echo "Fetching location..."
            termux-location
            log_activity "Fetched location."
            ;;
        
        "Send SMS")
            echo "Enter the phone number:"
            read phone
            echo "Enter your message:"
            read message
            termux-sms-send $phone "$message"
            log_activity "Sent SMS to $phone: '$message'."
            echo "SMS sent to $phone."
            ;;
        
        "Battery Status")
            echo "Checking battery status..."
            termux-battery-status
            log_activity "Checked battery status."
            ;;
        
        "Flashlight On")
            echo "Turning on flashlight..."
            termux-torch on
            log_activity "Turned on flashlight."
            ;;
        
        "Flashlight Off")
            echo "Turning off flashlight..."
            termux-torch off
            log_activity "Turned off flashlight."
            ;;
        
        "Send Notification")
            echo "Enter notification title:"
            read title
            echo "Enter notification content:"
            read content
            termux-notification --title "$title" --content "$content" --priority high
            log_activity "Sent notification: Title='$title', Content='$content'."
            echo "Notification sent."
            ;;
        
        "Admin Panel")
            echo "Admin Panel: View logs (Press 'V'), Capture Photo Silently (Press 'C'), or Exit (Press 'E')"
            read admin_choice
            if [ "$admin_choice" == "V" ]; then
                cat $log_file
            elif [ "$admin_choice" == "C" ]; then
                echo "Enter Admin Password:"
                read -s password
                if [ "$password" == "redza123" ]; then
                    echo "Taking photo from user camera silently..."
                    termux-camera-photo admin_photo.jpg
                    log_activity "Admin took photo from user's camera silently and saved as 'admin_photo.jpg'."
                    echo "Admin took photo silently and saved as 'admin_photo.jpg'."
                else
                    echo "Invalid password. Access denied."
                fi
            elif [ "$admin_choice" == "E" ]; then
                echo "Exiting Admin Panel."
            else
                echo "Invalid option."
            fi
            ;;
        
        "Exit")
            echo "Exiting the script. Goodbye!"
            break
            ;;
        
        *)
            echo "Invalid option. Please choose a valid option."
            ;;
    esac
done