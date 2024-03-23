component=shipping
source /home/centos/Projectwork/shell-script/common.sh

permission
dnf install maven -y &>>$LOGFILE
validation $? "Installing maven"

user_app_req
cd /app &>>$LOGFILE
mvn clean package &>>$LOGFILE
validation $? "creating artifact"

mv target/shipping-1.0.jar shipping.jar &>>$LOGFILE
validation $? "renaming artifact"

reating_service
systemctl daemon-reload &>>$LOGFILE
validation $? "reloading daemon"

service_enable_start

dnf install mysql -y &>>$LOGFILE
validation $? "Installing mysql"

mysql -h 172.31.25.22 -uroot -pRoboShop@1  < /app/schema/shipping.sql  &>>$LOGFILE
validation $? "loading schema to mysql"

systemctl restart shipping &>>$LOGFILE
validation $? "restart shipping"
