#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"
LOGFILE="/tmp/mongodb-$(date "+%Y-%m-%d")"

validation(){
  if [ $1 -eq 0 ]
    then 
      echo -e "$Y $2 ..... $G SUCCESS$N"
    else 
      echo -e "$Y $2 ..... $R FAILED$N"
      exit 1
  fi
}

permission(){
   if [ $ID -eq 0 ]
     then 
       echo -e "$G You are root user, Proceeding further $N"
     else
        echo -e "$R Please run as root user $N"
        exit 1 
   fi 
}

echo -e "$B Copying mongo.repo file $N"
permission
cp /home/centos/Projectwork/shell-script/mongo.repo  /etc/yum.repos.d/mongo.repo &>>$LOGFILE
validation $1 "Copying mongo.repo file"
sleep 3

echo -e "$B Installing mongodb $N"
dnf install mongodb-org -y &>>$LOGFILE
validation $1 "Installing mongodb"
sleep 3

echo -e "$B Enabling mongodb $N"
systemctl enable mongod &>>$LOGFILE
validation $1 "Enabling mongodb"
sleep 3

echo -e "$B Start MongoDB $N"
systemctl start mongod &>>$LOGFILE
validation $1 "Start MongoDB"
sleep 3

echo -e "$B Update address to Mongo conf filie $N"
sed -i s/127.0.0.1/0.0.0.0/g /etc/mongod.conf &>>$LOGFILE
validation $1 "Update address to Mongo conf filie"
sleep 3

echo -e "$B Restart MongoDB $N"
systemctl restart mongod &>>$LOGFILE
validation $1 "Restart MongoDB"
sleep 3
