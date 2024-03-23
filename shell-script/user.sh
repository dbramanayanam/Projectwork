#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"
LOGFILE="/tmp/user-$(date "+%Y-%m-%d").log"
MONGOSERVER=mongodb.dineshdevops.com

validation(){
  if [ $1 -eq 0 ]
    then 
      echo -e "$Y $2 ..... $G SUCCESS$N"
      sleep 3
    else 
      echo -e "$Y $2 ..... $R FAILED$N"
      exit 1
  fi
}

permission(){
   if [ $ID -eq 0 ]
     then 
       echo -e "$G You are root user, Proceeding further $N"
       sleep 3
     else
        echo -e "$R Please run as root user $N"
        exit 1 
   fi 
}

permission
dnf module disable nodejs -y &>>$LOGFILE
validation $? "Disabling latest nodejs modules" 

dnf module enable nodejs:18 -y &>>$LOGFILE
validation $? "Enabling nodejs module"

dnf install nodejs -y &>>$LOGFILE
validation $? "Install nodeJS"

id roboshop &>>$LOGFILE
if [ $? -ne 0 ]
 then 
   echo -e "$Y Creating user roboshop $N"
   useradd roboshop &>>$LOGFILE
   validation $? "adding user roboshop"
 else
    echo -e " $R user roboshop is already exists.. Skipping creating user$N"
fi

DIR="/app"
if [ -d "$DIR" ]
 then 
   echo -e "$R directory is already exists. Deleting and creating agian $N"
   rm -rf /app &>>$LOGFILE
   mkdir /app &>>$LOGFILE
   validation $? "Creating /app directory"
   
 else 
  echo -e "$G Creating /app directory $N" 
  mkdir /app &>>$LOGFILE
  validation $? "Creating /app directory"
fi

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>>$LOGFILE
validation $? "Downloading app content"

cd /app &>>$LOGFILE
unzip /tmp/user.zip &>>$LOGFILE
validation $? "Unzip content"

cd /app  &>>$LOGFILE
npm install &>>$LOGFILE
validation $? "Install dependencies"

cp /home/centos/Projectwork/shell-script/user.service  /etc/systemd/system/user.service &>>$LOGFILE
validation $? "Copying user.service file"

systemctl daemon-reload &>>$LOGFILE
validation $? "Install dependencies"

systemctl enable user &>>$LOGFILE
validation $? "Install dependencies"

systemctl start user &>>$LOGFILE
validation $? "Install dependencies"

cp /home/centos/Projectwork/shell-script/mongo.repo  /etc/yum.repos.d/mongo.repo &>>$LOGFILE
validation $? "Copying mongo.repo file"

dnf install mongodb-org-shell -y &>>$LOGFILE
validation $? "Instal mongo client"

mongo --host $MONGOSERVER </app/schema/user.js &>>$LOGFILE
validation $? "Loading schema"
