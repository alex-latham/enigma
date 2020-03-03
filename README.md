# ENIGMA

## Learning Goals / Areas of Focus
  * Practice breaking a program into logical components
  * Build classes that demonstrate single responsibilities
  * Test drive a well-designed Object Oriented solution
  * Work with file i/o

## Overview
In this project you’ll use Ruby to build a tool for cracking an encryption algorithm. Make sure you understand the Encryption Algorithm and plan out what classes you may need prior to starting.

Additionally, you will self assess your project before your evaluation. Make sure you read through the Evaluation Rubric prior to beginning so that you know what is expected of this project.

  * [Project Page](https://backend.turing.io/module1/projects/enigma/index)
  * [Setup](https://backend.turing.io/module1/projects/enigma/setup)
  * [Encryption Algorithm](https://backend.turing.io/module1/projects/enigma/encryption)
  * [Project Requirements](https://backend.turing.io/module1/projects/enigma/requirements)
  * [Submission](https://backend.turing.io/module1/projects/enigma/submission)
  * [Evaluation Rubric](https://backend.turing.io/module1/projects/enigma/rubric)

## How to Use ENIGMA
This tool has three command line interfaces (CLIs). An explanation for each is below:
  * *encrypt.rb*: takes two arguments--the location of an existing message file and an output location for encrypted text. Information about the encryption is returned in the CLI.

  `ruby runners/encrypt.rb message.txt encrypted.txt`

  * *decrypt.rb*: takes four arguments--the location of an encrypted file, an output location for decrypted text, a five-digit encryption key, and a six-digit date in DDMMYY format. Information about the decryption is returned in the CLI.

  `ruby runners/decrypt.rb encrypted.txt decrypted.txt <key> <date>`

  * *crack.rb*: takes three arguments--the location of an encrypted file, an output location for cracked text, and a six-digit encryption date in DDMMYY format. Information about the crack is returned in the CLI.

  `ruby runners/crack.rb encrypted.txt cracked.txt <date>`
