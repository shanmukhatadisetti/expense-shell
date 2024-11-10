source common.sh
component=backend

echo Disabling nodejs
dnf module disable nodejs -y &>>$log_file
stat_check

echo Enabling Nodejs 18 version
dnf module enable nodejs:18 -y &>>$log_file
stat_check

echo Installing Nodejs
dnf install nodejs -y &>>$log_file
stat_check

rm -rf /app

echo Adding user
useradd expense &>>$log_file
stat_check

echo Copying Backend service file to system
cp backend.service /etc/systemd/system/backend.service &>>$log_file
stat_check

mkdir /app

cd /app

download_and_extract

echo Installing Nodejs Dependencies
npm install &>>$log_file
stat_check

echo starting backend services
systemctl daemon-reload &>>$log_file

systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
stat_check

echo Installing Mysql Client
dnf install mysql -y &>>$log_file
stat_check

echo Loading Schema
mysql -h mysql.autonagar.in -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
stat_check