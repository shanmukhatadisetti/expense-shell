check_status() {
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi
}