echo Disabling mysql module
dnf module disable mysql -y
check_status

echo Copying mysql repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo
check_status

echo Installing Mysql
dnf install mysql-community-server -y
check_status

echo Enabling Mysql Services
systemctl enable mysqld
systemctl start mysqld
check_status

echo Setting-up Mysql-Root-Password
mysql_secure_installation --set-root-pass ExpenseApp@1
check_status