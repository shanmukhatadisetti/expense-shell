logs = /tmp/expense.log
dnf module disable nodejs -y &>>logs
dnf module enable nodejs:18 -y &>>logs
cp backend.service /etc/systemd/system/backend.service
dnf install nodejs -y &>>logs

useradd expense &>>logs
rm -rf /app
mkdir /app &>>logs

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>logs
cd /app
unzip /tmp/backend.zip &>>logs

npm install &>>logs
systemctl daemon-reload &>>logs

systemctl enable backend &>>logs
systemctl start backend &>>logs

dnf install mysql -y &>>logs

mysql -h mysql.autonagar.in -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>logs