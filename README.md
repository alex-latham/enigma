# How to Use ENIGMA
This tool has three command line interfaces (CLIs). An explanation for each is below:
  * *encrypt.rb*: takes two arguments--the location of an existing message file and an output location for encrypted text. Information about the encryption is returned in the CLI.

  `ruby runners/encrypt.rb message.txt encrypted.txt`

  * *decrypt.rb*: takes four arguments--the location of an encrypted file, an output location for decrypted text, a five-digit encryption key, and a six-digit date in DDMMYY format. Information about the decryption is returned in the CLI.

  `ruby runners/decrypt.rb encrypted.txt decrypted.txt <key> <date>`

  * *crack.rb*: takes three arguments--the location of an encrypted file, an output location for cracked text, and a six-digit encryption date in DDMMYY format. Information about the crack is returned in the CLI.

  `ruby runners/crack.rb encrypted.txt cracked.txt <date>`
