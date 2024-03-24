component=redis
source /home/centos/Projectwork/shell-script/common.sh

permission
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> $LOGFILE
validation $? "installing redis rpm file"

dnf module enable redis:remi-6.2 -y &>> $LOGFILE
validation $? "Enabling redis module"

dnf install redis -y &>> $LOGFILE
validation $? "installing redis"

sed -i s/127.0.0.1/0.0.0.0/g /etc/redis.conf &>> $LOGFILE 
validation $? "Modifying redis is conf file /etc/redis.conf with 0.0.0.0"

sed -i s/127.0.0.1/0.0.0.0/g /etc/redis/redis.conf &>> $LOGFILE
validation $? "Modifying /etc/redis/redis.conf with 0.0.0.0"

service_enable_start