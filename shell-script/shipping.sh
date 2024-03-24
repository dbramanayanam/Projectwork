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

creating_service

service_enable_start

dnf install mysql -y &>>$LOGFILE
validation $? "Installing mysql"

mysql -h mysql.dineshdevops.online -uroot -pRoboShop@1  < /app/schema/shipping.sql  &>>$LOGFILE
validation $? "loading schema to mysql"

systemctl restart shipping &>>$LOGFILE
validation $? "restart shipping"
