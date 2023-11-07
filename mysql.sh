source common.sh

echo Disable mysql 8 version
dnf module disable mysql -y &>>$log_file
stat_check

echo Copy Mysql repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
stat_check

echo install Mysql server
dnf install mysql-community-server -y &>>$log_file
stat_check

echo Start mysql service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
stat_check

echo setup root password
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
stat_check