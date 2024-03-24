component=user
source /home/centos/Projectwork/shell-script/common.sh
permission
install_nodejs
user_app_req
nodejs_dependencies
creating_service
service_enable_start
copy_mongo_repo_install_client
mongo --host mongodb.dineshdevops.online </app/schema/user.js &>>$LOGFILE
validation $? "Loading schema"
