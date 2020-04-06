require './lib/cracker'

abort("ERROR: wrong number of arguments (expected 3, received #{ARGV.length})") if ARGV.length != 3
abort('ERROR: first arg must be .txt file') if ARGV[0][-4..-1] != '.txt'
abort('ERROR: second arg must be .txt file') if ARGV[1][-4..-1] != '.txt'
abort('ERROR: fourth arg must be MMDDYY format') if !ARGV[2].scan(/\D/).empty? || ARGV[2].length != 6

ciphertext = File.read(ARGV[0])

cracker = Cracker.new
cracked_data = cracker.crack(ciphertext, ARGV[2])

File.open(ARGV[1], 'w') { |file| file.write(cracked_data[:decryption]) }

p "Created '#{ARGV[1]}' with the cracked key #{cracked_data[:key]}\
 and date #{cracked_data[:date]}"