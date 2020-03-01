require 'date'

class Enigma
  attr_reader :dictionary

  def initialize
    @dictionary = ("a".."z").to_a << " "
  end

  def generate_key
    unpadded_key = rand(99999).to_s
    "0" * (5 - unpadded_key.length) + unpadded_key
  end

  def generate_offset(date)
    date_squared = date.to_i**2
    date_squared.to_s[-4..-1]
  end

  def generate_shifts(key, date)
    keys = {a: key[0..1], b: key[1..2], c: key[2..3], d: key[3..4]}
    offset = generate_offset(date)
    offsets = {a: offset[0], b: offset[1], c: offset[2], d: offset[3]}
    keys.merge(offsets) { |_, shift, offset| shift.to_i + offset.to_i }
  end

  def shifted_dictionary(index, shifts)
    return @dictionary.rotate(shifts[:a]) if index % 4 == 0
    return @dictionary.rotate(shifts[:b]) if index % 4 == 1
    return @dictionary.rotate(shifts[:c]) if index % 4 == 2
    return @dictionary.rotate(shifts[:d]) if index % 4 == 3
  end

  def encrypt_string(message, key, date)
    shifts = generate_shifts(key, date)
    cipher = String.new

    message.each_char.with_index do |char, index|
      if @dictionary.include?(char)
        cipher += shifted_dictionary(index, shifts)[@dictionary.index(char)]
      else
        cipher += char
      end
    end
    cipher
  end

  def encrypt(message, key = generate_key, date = Date.today.strftime("%d%m%y"))
    {encryption: encrypt_string(message.downcase, key, date),
     key: key,
     date: date}
  end

  def decrypt_string(cipher, key, date)
    shifts = generate_shifts(key, date)
    message = String.new
  end

  def decrypt(cipher, key, date)
    {decryption: decrypt_string(cipher, key, date),
     key: key,
     date: date}
  end

end
