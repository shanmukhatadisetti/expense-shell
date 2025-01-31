source common.sh
logs=/tmp/expense.log
echo Disabling Nodejs
dnf module disable nodejs -y &>>$logs
check_status

echo Enabling Nodejs 18-version
dnf module enable nodejs:18 -y &>>$logs
check_status

cp backend.service /etc/systemd/system/backend.service

echo Installing Nodejs
dnf install nodejs -y &>>$logs
check_status

echo Adding Users
useradd expense &>>$logs
check_status

rm -rf /app
mkdir /app &>>$logs

echo Downloading Backend-zip Files
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$logs
check_status

cd /app

echo Unzipping Backend.zip File
unzip /tmp/backend.zip &>>$logs
check_status

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