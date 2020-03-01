require 'date'

class Enigma
  attr_reader :dictionary

  def initialize
    @dictionary = ("a".."z").to_a << " "
  end

  def generate_key
    rand(99999).to_s.rjust(5, "0")
  end

  def generate_offset(date)
    date_squared = date.to_i**2
    date_squared.to_s[-4..-1]
  end

  def generate_shifts(key, date, dir)
    keys = {a: key[0..1], b: key[1..2], c: key[2..3], d: key[3..4]}
    offset = generate_offset(date)
    offsets = {a: offset[0], b: offset[1], c: offset[2], d: offset[3]}
    keys.merge(offsets) { |_, shift, offset| dir * (shift.to_i + offset.to_i) }
  end

  def shifted_dictionary(index, shifts)
    return @dictionary.rotate(shifts[:a]) if index % 4 == 0
    return @dictionary.rotate(shifts[:b]) if index % 4 == 1
    return @dictionary.rotate(shifts[:c]) if index % 4 == 2
    return @dictionary.rotate(shifts[:d]) if index % 4 == 3
  end

  def mutate_string(string, key, date, dir)
    shifts = generate_shifts(key, date, dir)
    mutant = String.new
    string.each_char.with_index do |char, index|
      if @dictionary.include?(char)
        mutant += shifted_dictionary(index, shifts)[@dictionary.index(char)]
      else
        mutant += char
      end
    end
    mutant
  end

  def encrypt(message, key = generate_key, date = Date.today.strftime("%d%m%y"))
    {encryption: mutate_string(message.downcase, key, date, +1),
     key: key,
     date: date}
  end

  def decrypt(cipher, key, date)
    {decryption: mutate_string(cipher, key, date, -1),
     key: key,
     date: date}
  end
end
