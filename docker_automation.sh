#!/bin/bash

#email recipient list

TO="kulalashwanth@gmail.com"
SUBJECT="Docker Server Alert"
current_date=$(date)

#Get Docker status
dockerStatus=$(systemctl is-active docker)
dockerVersion=$(docker -v | awk '{print $3}' | tr -d ',')

#Current status
echo "Current time is $current_date and the docker status is: $dockerStatus"
echo "Current docker version: $dockerVersion"

#if docker is dead/inactive then send an email

if [ "$dockerStatus" != "active" ]; then
	echo -e "Docker is not running on $(hostname) at  $current_date\nStatus: $dockerStatus\n Docker Version: $dockerVersion" | mail -s "$SUBJECT - Docker is $dockerStatus" $TO

	sleep 10
	sudo systemctl restart docker
	new_status=$(systemctl is-active docker)
	new_date=$(date)

	if [ "$new_status" == "active" ]; then
		echo -e "Docker was restarted and now its healthy on $(hostname) at $new_date" | mail -s "$SUBJECT - dockerservice is restarted successfully..." $TO
	else
		echo -e "Docker was restart failed please check on  $(hostname) at $new_date" | mail -s "$SUBJECT - dockerservice is restarted not successfully..." $TO

	fi

fi

