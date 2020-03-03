require './lib/encryptor'

abort("ERROR: wrong number of arguments (expected 2, received #{ARGV.length})") if ARGV.length != 2
abort("ERROR: first arg must be .txt file") if ARGV[0][-4..-1] != ".txt"
abort("ERROR: second arg must be .txt file") if ARGV[1][-4..-1] != ".txt"

message = File.open(ARGV[0], "r")
plaintext = message.read
message.close

encryptor = Encryptor.new
encryption_data = encryptor.encrypt(plaintext)

encrypted = File.open(ARGV[1], "w")
encrypted.write(encryption_data[:encryption])
encrypted.close

p "Created '#{ARGV[1]}' with the key #{encryption_data[:key]}\
 and date #{encryption_data[:date]}"