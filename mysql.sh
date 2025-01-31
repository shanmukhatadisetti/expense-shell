source common.sh
logs=/tmp/expense.log
echo Disabling mysql module
dnf module disable mysql -y &>>$logs
check_status

echo Copying mysql repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$logs
check_status

echo Installing Mysql
dnf install mysql-community-server -y &>>$logs
check_status

echo Enabling Mysql Services
systemctl enable mysqld &>>$logs
systemctl start mysqld &>>$logs
check_status

echo Setting-up Mysql-Root-Password
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$logs
check_status