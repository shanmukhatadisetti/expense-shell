source common.sh
component=frontend

echo installing Nginx
dnf install nginx -y &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi



echo copying expense config file in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?

echo Removing old nginx content
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?

cd /usr/share/nginx/html

download_and_extract

echo Starting Nginx services
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
echo $?