source common.sh

echo Disabling Mysql
dnf module disable mysql -y &>>$log_file

echo Copying Mysql REpo
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file

echo Installing Mysql
dnf install mysql-community-server -y &>>$log_file

echo Mysql Services
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file

echo Setting up Mysql Username and Password
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file