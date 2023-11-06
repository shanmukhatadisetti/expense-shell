source common.sh
echo installing Nginx
dnf install nginx -y &>>log_file


echo copying expense config file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file

echo Removing old nginx content
rm -rf /usr/share/nginx/html/* &>>log_file

echo Downloading frontend code
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>log_file

cd /usr/share/nginx/html

echo Extracting frontend code
unzip /tmp/frontend.zip &>>log_file

echo Starting Nginx services
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file