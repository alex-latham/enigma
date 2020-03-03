require './lib/enigma'

encrypted = File.open(ARGV[0], "r")
ciphertext = encrypted.read

enigma = Enigma.new
decryption_data = enigma.crack(ciphertext, ARGV[2])

cracked = File.open(ARGV[1], "w")
cracked.write(decryption_data[:decryption])
cracked.close

p "Created '#{ARGV[1]}' with the cracked key #{decryption_data[:key]} and date #{decryption_data[:date]}"
