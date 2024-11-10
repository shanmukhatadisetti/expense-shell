source common.sh

echo Installing nginx
dnf install nginx -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
fi

echo Placing expense config file in nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[om"
fi

echo  Removing Old Nginx content
rm -rf /usr/share/nginx/html/* &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
fi

echo Download Frontend Code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
fi

cd /usr/share/nginx/html

echo Extracting Frontend Code
unzip /tmp/frontend.zip &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
fi

echo Starting Nginx Service
systemctl enable nginx &>>log_file

systemctl restart nginx &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
fi