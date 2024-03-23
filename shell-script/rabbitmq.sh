component=rabbitmq-server
source /home/centos/Projectwork/shell-script/common.sh

permission

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$LOGFILE
validation $? "Adding repo scripts"

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$LOGFILE
validation $? "Adding rabbitmq repos"

dnf install rabbitmq-server -y &>>$LOGFILE
validation $? "Installing rabbitmq-server"

service_enable_start 

rabbitmqctl add_user roboshop roboshop123 &>>$LOGFILE
validation $? "Adding user to rabbitmq"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*". &>>$LOGFILE
validation $? "set permissions to rabbitmq"
