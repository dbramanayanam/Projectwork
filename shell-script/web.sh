## This script is for installing and configuring  nginx server ####
#!/bin/bash

ID=$(id -u)
R="\e[31m]"
G="\e[32m]"
Y="\e[33m]"
LOGFILE=/tmp/logfile-$(date "+%Y-%m-%d")
privilage(){
 if [ $ID -eq 0 ]
  then 
   echo -e "$G You are root user. Proceeding with installation $N"
  else 
   echo -e " $R You are not root user. Please run as root user to proceed $N"
 fi
}

validation(){
    if [ $1 -ne 0 ]
      then 
        echo -e "$R ERROR: $2 is falied. Please check logs $N"
        exit 1 
    else
        echo -e "$G SUCCESS: $Y $2 is successfull $N"   
    fi      
}


echo -e "$Y Installing Nginx $N"
privilage 
dnf install nginx -y &>> $LOGFILE
validation $? "Installation of Nginx"
sleep 3

echo -e "$Y Enabling Nginx $N"
systemctl enable nginx &>> $LOGFILE
validation $? "Enabling Nginx"
sleep 3

echo -e "$Y Starting Nginx $N"
systemctl start nginx &>> $LOGFILE
validation $? "Starting Nginx"
sleep 3

echo -e "$Y Removing default content of Nginx $N"
rm -rf /usr/share/nginx/html/* &>> $LOGFILE
validation $? "Removing default content of Nginx"
sleep 3

echo -e "$Y Downloading and extracting project content $N"
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $LOGFILE
validation $? "Downloading project content "
cd /usr/share/nginx/html &>> $LOGFILE
validation $? "Changing directory "
unzip /tmp/web.zip &>> $LOGFILE
validation $? "extracting project content "
sleep 3

echo -e "$Y Copying roboshop.conf file $N"
cp /home/centos/Projectwork/shell-script/roboshop.conf  /etc/nginx/default.d/roshop.conf &>> $LOGFILE
validation $? "Copying roboshop.conf file"
sleep 3

echo -e "$Y Restarting Nginx $N"
systemctl restart nginx &>> $LOGFILE
validation $? "restarting Nginx"
sleep 3

# dnf install ngin# systemctl enable n# systemctl start nginx
# rm -rf /usr/share/nginx/html/*
# curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip
# cd /usr/share/nginx/html
# unzip /tmp/web.zip
# systemctl restart nginx 
