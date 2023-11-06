echo Disable mysql
dnf module disable mysql -y &>>/tmp/expense.log

echo Coping Mysql repo
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/expense.log


dnf install mysql-community-server -y &>>/tmp/expense.log

echo Starting mysql services
systemctl enable mysqld &>>/tmp/expense.log
systemctl start mysqld &>>/tmp/expense.log

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>/tmp/expense.log