require './lib/decryptor'

abort("ERROR: wrong number of arguments (expected 4, received #{ARGV.length})") if ARGV.length != 4
abort("ERROR: first arg must be .txt file") if ARGV[0][-4..-1] != ".txt"
abort("ERROR: second arg must be .txt file") if ARGV[1][-4..-1] != ".txt"
abort("ERROR: third arg be five digits") if !ARGV[2].scan(/\D/).empty? ||
  ARGV[2].length != 5
abort("ERROR: fourth arg must be MMDDYY format") if !ARGV[3].scan(/\D/).empty? ||
  ARGV[3].length != 6

ciphertext = File.read(ARGV[0])

decryptor = Decryptor.new
decrypted_data = decryptor.decrypt(ciphertext, ARGV[2], ARGV[3])

File.open(ARGV[1], "w") { |file| file.write(decrypted_data[:decryption]) }

p "Created '#{ARGV[1]}' with the key #{decrypted_data[:key]}\
 and date #{decrypted_data[:date]}"