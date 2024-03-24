component=catalogue
source /home/centos/Projectwork/shell-script/common.sh

install_nodejs
user_app_req
nodejs_dependencies
creating_service
service_enable_start
copy_mongo_repo_install_client
mongo --host $MONGOSERVER </app/schema/catalogue.js &>>$LOGFILE
validation $? "loading schema"
