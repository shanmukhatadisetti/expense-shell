check_status() {
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
fi
}

Download_and_Extarct () {
  echo Downloading $component-zip Files
  curl -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip &>>$logs
  check_status

  echo Unzipping $component.zip File
  unzip /tmp/$component.zip &>>$logs
  check_status
}