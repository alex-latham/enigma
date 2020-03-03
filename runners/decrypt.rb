require './lib/decryptor'

encrypted = File.open(ARGV[0], "r")
ciphertext = encrypted.read

decryptor = Decryptor.new
decryption_data = decryptor.decrypt(ciphertext, ARGV[2], ARGV[3])

decrypted = File.open(ARGV[1], "w")
decrypted.write(decryption_data[:decryption])
decrypted.close

p "Created '#{ARGV[1]}' with the key #{decryption_data[:key]}\
 and date #{decryption_data[:date]}"
