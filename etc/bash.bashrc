# ...

# send mail on logon
echo "ALERT - Shell Access on: $(date) $(who)" | mail -s "Alert: Shell Access on $(hostname -f)" root