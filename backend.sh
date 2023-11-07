source common.sh
component=backend

type npm &>>$log_file
if [ $? -ne 0 ], then
  echo Download nodejs repos
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
  stat_check

  echo Installing nodejs
  dnf install nodejs -y &>>$log_file
fi
stat_check

echo copying backend configuration
cp backend.service /etc/systemd/system/backend.service &>>$log_file
stat_check

echo removing app content
rm -rf cd /app &>>$log_file
stat_check

echo adding user to application
id expense &>>$log_file
if [ $? -ne 0 ], then
  useradd expense &>>$log_file
fi
stat_check

mkdir /app

cd /app

download_and_extract

echo installing Nodejs Dependencies
npm install &>>$log_file
stat_check

echo start Backend Service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
stat_check

echo Installing Mysql client
dnf install mysql -y &>>$log_file
stat_check

echo Load schema
mysql -h mysql.autonagar.in -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
stat_check