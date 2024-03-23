
#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"
LOGFILE="/tmp/catalogue-$(date "+%Y-%m-%d").log"
MONGOSERVER=172.31.25.22

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
validation $? "Disabling nodej"


dnf module enable nodejs:18 -y &>>$LOGFILE
validation $? "Enabling nodejs18"


dnf install nodejs -y &>>$LOGFILE
validation $? "Installing NodeJS"


id roboshop &>>$LOGFILE
if [ $? -ne 0 ]
 then 
   echo -e "$Y Creating user roboshop $N"
   useradd roboshop &>>$LOGFILE
   validation $? "adding user roboshop"
 else
    echo -e " $R user roboshop is already exists.. Skipping creating user"
fi

mkdir /app &>>$LOGFILE
validation $? "Creating /app directory"


curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>>$LOGFILE
validation $? "Downloading catalogue content"


cd /app &>>$LOGFILE
unzip /tmp/catalogue.zip &>>$LOGFILE
validation $? "extracting the content"

cd /app &>>$LOGFILE
npm install &>>$LOGFILE
validation $? "Installing dependencies"

cp /home/centos/Projectwork/shell-script/catalogue.service  /etc/systemd/system/catalogue.service &>>$LOGFILE
validation $? "Copying catalogue.service file"

systemctl daemon-reload. &>>$LOGFILE
validation $? "reloading daemon"

systemctl enable catalogue &>>$LOGFILE
validation $? "Creating /app directory"


systemctl start catalogue &>>$LOGFILE
validation $? "Starting catalogue service"

cp /home/centos/Projectwork/shell-script/mongo.repo  /etc/yum.repos.d/mongo.repo &>>$LOGFILE
validation $? "Copying mongo.repo file"

dnf install mongodb-org-shell -y &>>$LOGFILE
validation $? "Installing Mongo-client"

mongo --host $MONGOSERVER </app/schema/catalogue.js &>>$LOGFILE
validation $? "loading schema"
