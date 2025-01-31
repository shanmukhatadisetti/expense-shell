source common.sh
logs=/tmp/expense.log
component=backend

echo Disabling Nodejs
dnf module disable nodejs -y &>>$logs
check_status

echo Enabling Nodejs 18-version
dnf module enable nodejs:18 -y &>>$logs
check_status

echo Copying Backend service
cp backend.service /etc/systemd/system/backend.service

echo Installing Nodejs
dnf install nodejs -y &>>$logs
check_status

echo Adding Users
id expense
Useradd
check_status

rm -rf /app
mkdir /app &>>$logs
cd /app

Download_and_Extarct

echo Installing Dependencies
npm install &>>$logs
check_status


echo Installing Mysql-Client
dnf install mysql -y &>>$logs
check_status

echo Setting-up Mysql-Username and Password
mysql -h mysql.autonagar.in -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$logs
check_status

echo Starting Backend-Services
systemctl daemon-reload &>>$logs
systemctl enable backend &>>$logs
systemctl start backend &>>$logs
check_status