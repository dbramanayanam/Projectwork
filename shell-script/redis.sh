#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"
LOGFILE="/tmp/redis-$(date "+%Y-%m-%d").log"
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
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> $LOGFILE
validation $? "installing redis rpm file"

dnf module enable redis:remi-6.2 -y &>> $LOGFILE
validation $? "Enabling redis module"

dnf install redis -y &>> $LOGFILE
validation $? "installing redis"

sed -i s/127.0.0.1/0.0.0.0/g /etc/redis.conf &>> $LOGFILE 
validation $? "Modifying redis is conf file /etc/redis.conf with 0.0.0.0"

sed -i s/127.0.0.1/0.0.0.0/g /etc/redis/redis.conf &>> $LOGFILE
validation $? "Modifying /etc/redis/redis.conf with 0.0.0.0"

systemctl enable redis  &>> $LOGFILE
validation $? "enable redis". &>> $LOGFILE

systemctl start redis &>> $LOGFILE
validation $? "start redis". &>> $LOGFILE