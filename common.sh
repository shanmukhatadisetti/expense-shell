log_file=/tmp/expense.log

download_and_extract() {
  echo Downloading $component code
  curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
  stat_check

  echo Extracting $component code
  unzip /tmp/$component.zip &>>$log_file
  stat_check
}

stat_check() {
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILED
    exit 1
  fi
}