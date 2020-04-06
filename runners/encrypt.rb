require './lib/encryptor'

abort("ERROR: wrong number of arguments (expected 2, received #{ARGV.length})") if ARGV.length != 2
abort('ERROR: first arg must be .txt file') if ARGV[0][-4..-1] != '.txt'
abort('ERROR: second arg must be .txt file') if ARGV[1][-4..-1] != '.txt'

plaintext = File.read(ARGV[0], 'r')

encryptor = Encryptor.new
encrypted_data = encryptor.encrypt(plaintext)

File.open(ARGV[1], 'w') { |file| file.write(encrypted_data[:encryption]) }

p "Created '#{ARGV[1]}' with the key #{encrypted_data[:key]}\
 and date #{encrypted_data[:date]}"