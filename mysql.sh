source common.sh

echo Disabling Mysql
dnf module disable mysql -y &>>$log_file
stat_check

echo Copying Mysql REpo
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
stat_check

echo Installing Mysql
dnf install mysql-community-server -y &>>$log_file
stat_check

echo Mysql Services
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
stat_check

echo Setting up Mysql Username and Password
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
stat_check