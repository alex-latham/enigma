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
This tool has several tools available for use, including four command line interfaces (CLIs). An explanation for each is below:
* `lib/encrypt.rb`: takes two arguments--the location of an existing message file and an output location for encrypted text. Information about the encryption is returned in the CLI.
* `lib/decrypt.rb`: takes four arguments--the location of an encrypted file, an output location for decrypted text, a five-digit encryption key, and a six-digit date in DDMMYY format. Information about the decryption is returned in the CLI.
* `lib/crack.rb`: takes three arguments--the location of an encrypted file, an output location for cracked text, and a six-digit encryption date in DDMMYY format. Information about the crack is returned in the CLI.
* `runner.rb`: opens a pry session in which every command available to ENIGMA is available for testing purposes. Use `cd enigma` followed by `ls` to see a list of all methods.

## Self Assessment
* **Functionality: 4**
  - Cracking method and command line interface successfully implemented.
* **Object Oriented Programming: 4**
  - A single Enigma class is assisted with two modules--Generable, which is responsible for generating dates, keys, offsets, shifts, and strings, and Crackable, which contains methods employed in use for cracking. Breaking out responsibilities into modules improves organization of the code in that the purposes of individual methods are made clear by the context of their locations.
* **Ruby Conventions and Mechanics: 4**
  - Classes, methods, and variables are named to clearly communicate their purpose. Code is all properly indented and syntax is consistent. No methods are longer than 10 lines long. Enumerables and data structures chosen are generally the most efficient tool for a given job.
* **Test Driven Development: 4**
  - Stubs are used to ensure testing is more robust (i.e., testing methods that include factors such as randomness and today's date), and to improve testing efficiency. Test coverage metrics show 100% coverage.
* **Version Control: 4**
  - At least 85 commits have been made to this project. All six pull requests include related and logical chunks of functionality, and are named and documented to clearly communicate the purpose of the pull request. No commits include multiple pieces of functionality. No commit message is ambiguous.
