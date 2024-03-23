component=cart
source common.sh

permission
dnf module disable nodejs -y &>>$LOGFILE
validation $? "Disabling nodejs module" 

dnf module enable nodejs:18 -y &>>$LOGFILE
validation $? "Enabling nodejs:18 module"

dnf install nodejs -y &>>$LOGFILE
validation $? "Installing nodejs"

user_app_req
cd /app 
npm install &>>$LOGFILE
validation $? "Installing dependencies"

cp /home/centos/Projectwork/shell-script/cart.service  /etc/systemd/system/cart.service &>>$LOGFILE
validation $? "Copying cart.service file"

systemctl daemon-reload &>>$LOGFILE
validation $? "reloading daemon"

systemctl enable cart &>>$LOGFILE
validation $? "Enabling cart"

systemctl start cart &>>$LOGFILE
validation $? "Starting cart"