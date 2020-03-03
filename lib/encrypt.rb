require './lib/enigma'

message = File.open(ARGV[0], "r")
plaintext = message.read

enigma = Enigma.new
encryption_data = enigma.encrypt(plaintext)

encrypted = File.open(ARGV[1], "w")
encrypted.write(encryption_data[:encryption])
encrypted.close

p "Created '#{ARGV[1]}' with the key #{encryption_data[:key]} and date #{encryption_data[:date]}"
