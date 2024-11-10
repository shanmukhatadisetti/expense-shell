source common.sh
component=frontend
echo Installing nginx
dnf install nginx -y &>>$log_file
stat_check

echo Placing expense config file in nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
stat_check

echo  Removing Old Nginx content
rm -rf /usr/share/nginx/html/* &>>$log_file
stat_check

cd /usr/share/nginx/html


download_and_extract

echo Starting Nginx Service
systemctl enable nginx &>>$log_file

systemctl restart nginx &>>$log_file
stat_check