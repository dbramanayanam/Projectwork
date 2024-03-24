component=payment
source /home/centos/Projectwork/shell-script/common.sh

permission
dnf install python36 gcc python3-devel -y &>>$LOGFILE
validation $? "Installing python"
user_app_req

cd /app &>>$LOGFILE
pip3.6 install -r requirements.txt &>>$LOGFILE
validation $? "Installing pyton dependencies"

creating_service
service_enable_start