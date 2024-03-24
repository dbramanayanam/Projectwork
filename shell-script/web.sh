component=nginx
source /home/centos/Projectwork/shell-script/common.sh

permission 
dnf install nginx -y &>> $LOGFILE
validation $? "Installation of Nginx"

service_enable_start

rm -rf /usr/share/nginx/html/* &>> $LOGFILE
validation $? "Removing default content of Nginx"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $LOGFILE
validation $? "Downloading project content "
cd /usr/share/nginx/html &>> $LOGFILE
validation $? "Changing directory "
unzip /tmp/web.zip &>> $LOGFILE
validation $? "extracting project content "

cp /home/centos/Projectwork/shell-script/roboshop.conf\   /etc/nginx/default.d/roshop.conf &>> $LOGFILE
validation $? "Copying roboshop.conf file"

echo -e "$Y Restarting Nginx $N"
systemctl restart nginx &>> $LOGFILE
validation $? "restarting Nginx"
