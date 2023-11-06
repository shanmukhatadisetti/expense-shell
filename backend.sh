source common.sh
echo Download nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file

echo Installing nodejs
dnf install nodejs -y &>>$log_file

echo copying backend configuration
cp backend.service /etc/systemd/system/backend.service &>>$log_file

echo removing app content
rm -rf cd /app &>>$log_file

echo adding user to application
useradd expense &>>$log_file

mkdir /app

echo Downloading application content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file

cd /app

echo Extracting application content
unzip /tmp/backend.zip &>>$log_file

echo installing Nodejs Dependencies
npm install &>>$log_file

echo start Backend Service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file

echo Installing Mysql client
dnf install mysql -y &>>$log_file

echo Load schema
mysql -h mysql.autonagar.in -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file