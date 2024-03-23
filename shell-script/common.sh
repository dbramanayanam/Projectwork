ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"
LOGFILE="/tmp/${component}-$(date "+%Y-%m-%d").log"
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

user_app_req(){

id roboshop &>>$LOGFILE
if [ $? -ne 0 ]
 then 
   echo -e "$Y Creating user roboshop $N"
   useradd roboshop &>>$LOGFILE
   validation $? "adding user roboshop"
 else
    echo -e " $R user roboshop is already exists.. Skipping creating user"
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

curl -o /tmp/${component}.zip https://roboshop-builds.s3.amazonaws.com/${component}.zip &>>$LOGFILE
validation $? "Downloading ${component} content"


cd /app &>>$LOGFILE
unzip /tmp/${component}.zip &>>$LOGFILE
validation $? "extracting the content"

}

service_enable_start(){

systemctl enable ${component} &>>$LOGFILE
validation $? "Enabling ${component} service"

systemctl start ${component} &>>$LOGFILE
validation $? "Starting ${component} service"

}
creating_service(){
 cp /home/centos/Projectwork/shell-script/${component}.service  /etc/systemd/system/${component}.service &>>$LOGFILE
 validation $? "Copying ${component}.service file"

}