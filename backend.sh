source=common.sh

echo Disabling nodejs
dnf module disable nodejs -y &>>log_file
echo Enabling Nodejs 18 version
dnf module enable nodejs:18 -y &>>log_file

echo Installing Nodejs
dnf install nodejs -y &>>log_file
rm -rf /app

echo Adding user
useradd expense &>>log_file

echo Copying Backend service file to system
cp backend.service /etc/systemd/system/backend.service &>>log_file

mkdir /app

echo Downloading backend content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file

cd /app

echo Extracting Backend Content
unzip /tmp/backend.zip &>>log_file

echo Installing Nodejs Dependencies
npm install &>>log_file

echo starting backend services
systemctl daemon-reload &>>log_file

systemctl enable backend &>>log_file
systemctl start backend &>>log_file

echo Installing Mysql Client
dnf install mysql -y

echo Loading Schema
mysql -h mysql.autonagar.in -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file