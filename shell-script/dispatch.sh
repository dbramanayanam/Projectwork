component=dispatch
source /home/centos/Projectwork/shell-script/common.sh

permission
dnf install golang -y &>> $LOGFILE
validation $? "Installing golang"

user_app_req

cd /app &>> $LOGFILE
go mod init dispatch &>> $LOGFILE
go get &>> $LOGFILE
go build &>> $LOGFILE
validation $? "Installing dependencies"

creating_service

systemctl daemon-reload &>> $LOGFILE
validation $? "reloading daemon"

service_enable_start