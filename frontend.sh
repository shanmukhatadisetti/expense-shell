source common.sh
component=frontend

echo Installing Nginx
dnf install nginx -y
check_status

echo Placing expense conf file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf
check_status

echo Removing Old Content
rm -rf /usr/share/nginx/html/*
check_status

cd /usr/share/nginx/html


Download_and_Extarct

echo Starting Nginx Service
systemctl enable nginx
systemctl restart nginx
check_status