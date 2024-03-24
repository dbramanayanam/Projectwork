component=nginx
source /home/centos/Projectwork/shell-script/common.sh

echo -e "$Y Installing Nginx $N"
permission 
dnf install nginx -y &>> $LOGFILE
validation $? "Installation of Nginx"

service_enable_start

echo -e "$Y Removing default content of Nginx $N"
rm -rf /usr/share/nginx/html/* &>> $LOGFILE
validation $? "Removing default content of Nginx"

echo -e "$Y Downloading and extracting project content $N"
curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $LOGFILE
validation $? "Downloading project content "
cd /usr/share/nginx/html &>> $LOGFILE
validation $? "Changing directory "
unzip /tmp/web.zip &>> $LOGFILE
validation $? "extracting project content "

echo -e "$Y Copying roboshop.conf file $N"
cp /home/centos/Projectwork/shell-script/roboshop.conf\   /etc/nginx/default.d/roshop.conf &>> $LOGFILE
validation $? "Copying roboshop.conf file"

echo -e "$Y Restarting Nginx $N"
systemctl restart nginx &>> $LOGFILE
validation $? "restarting Nginx"

# dnf install ngin# systemctl enable n# systemctl start nginx
# rm -rf /usr/share/nginx/html/*
# curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip
# cd /usr/share/nginx/html
# unzip /tmp/web.zip
# systemctl restart nginx 
