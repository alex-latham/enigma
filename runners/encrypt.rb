require './lib/encryptor'

message = File.open(ARGV[0], "r")
plaintext = message.read

encryptor = Encryptor.new
encryption_data = encryptor.encrypt(plaintext)

encrypted = File.open(ARGV[1], "w")
encrypted.write(encryption_data[:encryption])
encrypted.close

p "Created '#{ARGV[1]}' with the key #{encryption_data[:key]}\
 and date #{encryption_data[:date]}"
