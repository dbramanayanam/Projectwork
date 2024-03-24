component=mysqld
source /home/centos/Projectwork/shell-script/common.sh

permission
dnf module disable mysql -y &>>$LOGFILE
validation $? "Disabling mysql"


cp /home/centos/Projectwork/shell-script/mysql.repo  /etc/yum.repos.d/mysql.repo &>>$LOGFILE
validation $? "Copying mysql.repo file"

dnf install mysql-community-server -y &>>$LOGFILE
validation $? "installing mysql server"

service_enable_start

mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOGFILE
validation $? "set rootpassword to mysql db"
mysql -uroot -pRoboShop@1