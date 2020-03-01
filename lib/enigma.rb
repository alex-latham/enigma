require 'date'

class Enigma
  attr_reader :charset

  def initialize
    @charset = ("a".."z").to_a << " "
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
    keys.merge(offsets) do |_, key_shift, offset_shift|
      dir * (key_shift.to_i + offset_shift.to_i)
    end
  end

  def shifted_charset(index, shifts)
    return @charset.rotate(shifts[:a]) if index % 4 == 0
    return @charset.rotate(shifts[:b]) if index % 4 == 1
    return @charset.rotate(shifts[:c]) if index % 4 == 2
    return @charset.rotate(shifts[:d]) if index % 4 == 3
  end

  def mutate_string(string, key, date, dir)
    shifts = generate_shifts(key, date, dir)
    mutant_str = String.new
    string.each_char.with_index do |char, index|
      if @charset.include?(char)
        mutant_str += shifted_charset(index, shifts)[@charset.index(char)]
      else
        mutant_str += char
      end
    end
    mutant_str
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
