## This script is for installing and configuring  nginx server ####
#!/bin/bash

ID=$(id -u)
R="\e[31m]"
G="\e[32m]"
Y="\e[33m]"
LOGFILE=/tmp/logfile-$(date "+%Y-%m-%d")
privilage(){
if [ $ID -eq 0 ];
then 
 echo -e "$G You are root user. Proceeding with installation $N"
else 
  echo -e " $R You are not root user. Please run as root user to proceed $N"
fi
}

validation(){
if [ $1 -eq 0 ];
 then 
  echo -e "$G SUCCESS: $Y $2 is successfull $N"
 else
   echo -e "$R ERROR: $2 is falied. Please check logs $N"
fi      
}


echo -e "$Y Installing Nginx $N"
privilage 
dnf install nginx -y &>> $LOGFILE
sleep 3
validation $? "Installation of Nginx"

echo -e "$Y Enabling Nginx $N"
systemctl enable nginx &>> $LOGFILE
sleep 3
validation $? "Enabling Nginx"

echo -e "$Y Starting Nginx $N"
systemctl start nginx &>> $LOGFILE
sleep 3
validation $? "Starting Nginx"

echo -e "$Y Removing default content of Nginx $N"
rm -rf /usr/share/nginx/html/* &>> $LOGFILE
sleep 3
validation $? "Removing default content of Nginx"

echo -e "$Y Downloading and extracting project content $N"
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $LOGFILE
cd /usr/share/nginx/html &>> $LOGFILE
unzip /tmp/web.zip &>> $LOGFILE
cd 
cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>> $LOGFILE
sleep 3
validation $? "Downloading and extracting project content "

echo -e "$Y Restarting Nginx $N"
systemctl restart nginx &>> $LOGFILE
sleep 3
validation $? "restarting Nginx"

# dnf install ngin# systemctl enable n# systemctl start nginx
# rm -rf /usr/share/nginx/html/*
# curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip
# cd /usr/share/nginx/html
# unzip /tmp/web.zip
# systemctl restart nginx 
