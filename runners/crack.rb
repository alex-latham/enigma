require './lib/cracker'

abort("ERROR: wrong number of arguments (expected 3, received #{ARGV.length})") if ARGV.length != 3
abort("ERROR: first arg must be .txt file") if ARGV[0][-4..-1] != ".txt"
abort("ERROR: second arg must be .txt file") if ARGV[1][-4..-1] != ".txt"
abort("ERROR: fourth arg must be MMDDYY format") if !ARGV[2].scan(/\D/).empty? || ARGV[2].length != 6

encrypted = File.open(ARGV[0], "r")
ciphertext = encrypted.read

cracker = Cracker.new
decryption_data = cracker.crack(ciphertext, ARGV[2])

cracked = File.open(ARGV[1], "w")
cracked.write(decryption_data[:decryption])
cracked.close

p "Created '#{ARGV[1]}' with the cracked key #{decryption_data[:key]}\
 and date #{decryption_data[:date]}"
