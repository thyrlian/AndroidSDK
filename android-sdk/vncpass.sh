#!/usr/bin/expect -f
spawn vncpasswd
expect "Password:"
send "android\r"
expect "Verify:"
send "android\r"
expect "Would you like to enter a view-only password (y/n)?"
send "y\r"
expect "Password:"
send "docker\r"
expect "Verify:"
send "docker\r"
expect eof