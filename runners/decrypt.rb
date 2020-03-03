require './lib/decryptor'

abort("ERROR: wrong number of arguments (expected 4, received #{ARGV.length})") if ARGV.length != 4
abort("ERROR: first arg must be .txt file") if ARGV[0][-4..-1] != ".txt"
abort("ERROR: second arg must be .txt file") if ARGV[1][-4..-1] != ".txt"
abort("ERROR: third arg be five digits") if !ARGV[2].scan(/\D/).empty? ||
  ARGV[2].length != 5
abort("ERROR: fourth arg must be MMDDYY format") if !ARGV[3].scan(/\D/).empty? ||
  ARGV[3].length != 6

encrypted = File.open(ARGV[0], "r")
ciphertext = encrypted.read
encrypted.close

decryptor = Decryptor.new
decryption_data = decryptor.decrypt(ciphertext, ARGV[2], ARGV[3])

decrypted = File.open(ARGV[1], "w")
decrypted.write(decryption_data[:decryption])
decrypted.close

p "Created '#{ARGV[1]}' with the key #{decryption_data[:key]}\
 and date #{decryption_data[:date]}"