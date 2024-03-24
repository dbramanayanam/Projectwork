component=mongodb
source /home/centos/Projectwork/shell-script/common.sh

echo -e "$B Copying mongo.repo file $N"
permission
cp /home/centos/Projectwork/shell-script/mongo.repo  /etc/yum.repos.d/mongo.repo &>>$LOGFILE
validation $? "Copying mongo.repo file"
sleep 3

echo -e "$B Installing mongodb $N"
dnf install mongodb-org -y &>>$LOGFILE
validation $? "Installing mongodb"
sleep 3

echo -e "$B Enabling mongodb $N"
systemctl enable mongod &>>$LOGFILE
validation $? "Enabling mongodb"
sleep 3

echo -e "$B Start MongoDB $N"
systemctl start mongod &>>$LOGFILE
validation $? "Start MongoDB"
sleep 3

echo -e "$B Update address to Mongo conf filie $N"
sed -i s/127.0.0.1/0.0.0.0/g /etc/mongod.conf &>>$LOGFILE
validation $? "Update address to Mongo conf filie"
sleep 3

echo -e "$B Restart MongoDB $N"
systemctl restart mongod &>>$LOGFILE
validation $? "Restart MongoDB"
sleep 3
