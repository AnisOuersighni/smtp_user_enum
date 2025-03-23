# smtp_user_enum
bash script to automate VALID usernames searching using smtp from a wordlist and choosen Method ( VRFY, RCPT, EXPN ). 
**Note** : Adapt the sleep time based on your connectivity and responsiveness of your target.

> Usage: ./smtp_test.sh <smtp_server> <port> <wordlist> [command] [domain]

The Default command is VRFY
