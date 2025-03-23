# smtp_user_enum
bash script to automate VALID usernames searching using smtp from a wordlist and choosen Method ( VRFY, RCPT, EXPN ). 
**Note** : 
  Adapt the sleep time based on your connectivity and responsiveness of your target.
  You can use a tool such as username-anarchy to generate variants of possible usernames from a provided list of collected users => ./username-anarchy  --input-file ./workers_names.txt > workers.txt



> Usage: ./smtp_users_check.sh <smtp_server> <port> <wordlist> [command] [domain]

The Default command is VRFY

