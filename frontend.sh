source common.sh
logs=/tmp/expense.log
component=frontend

echo Installing Nginx
dnf install nginx -y &>>$logs
check_status

echo Placing expense conf file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$logs
check_status

echo Removing Old Content
rm -rf /usr/share/nginx/html/* &>>$logs
check_status

cd /usr/share/nginx/html


Download_and_Extarct

echo Starting Nginx Service
systemctl enable nginx &>>$logs
systemctl restart nginx &>>$logs
check_status