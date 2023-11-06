echo installing Nginx
dnf install nginx -y &>>/tmp/expense.log


echo copying expense config file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log

echo Removing old nginx content
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log

echo Downloading frontend code
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/expense.log

cd /usr/share/nginx/html

echo Extracting frontend code
unzip /tmp/frontend.zip &>>/tmp/expense.log

echo Starting Nginx services
systemctl enable nginx >>/tmp/expense.log
systemctl restart nginx >>/tmp/expense.log