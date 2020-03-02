require 'date'

class Enigma
  attr_reader :charset

  def initialize
    @charset = ("a".."z").to_a << " "
  end

  def generate_today_date
    Date.today.strftime("%d%m%y")
  end

  def generate_key
    rand(99999).to_s.rjust(5, "0")
  end

  def generate_offset(date)
    date_squared = date.to_i**2
    date_squared.to_s[-4..-1]
  end

  def generate_shifts(key, date, direction)
    keys = {a: key[0..1], b: key[1..2], c: key[2..3], d: key[3..4]}
    offset = generate_offset(date)
    offsets = {a: offset[0], b: offset[1], c: offset[2], d: offset[3]}
    keys.merge(offsets) do |_, key_shift, offset_shift|
      ((key_shift.to_i + offset_shift.to_i) * direction ) % 27
    end
  end

  def shift_charset(index, shifts)
    return @charset.rotate(shifts[:a]) if index % 4 == 0
    return @charset.rotate(shifts[:b]) if index % 4 == 1
    return @charset.rotate(shifts[:c]) if index % 4 == 2
    return @charset.rotate(shifts[:d]) if index % 4 == 3
  end

  def mutate_string(string, key, date, direction)
    shifts = generate_shifts(key, date, direction)
    mutated_string = String.new
    string.each_char.with_index do |char, index|
      if @charset.include?(char)
        mutated_string += shift_charset(index, shifts)[@charset.index(char)]
      else
        mutated_string += char
      end
    end
    mutated_string
  end

  def encrypt(plaintext, key = generate_key, date = generate_today_date)
    key = generate_key if key == nil
    date = generate_today_date if date  == nil
    {encryption: mutate_string(plaintext.downcase, key, date, +1),
     key: key,
     date: date}
  end

  def decrypt(ciphertext, key, date = generate_today_date)
    {decryption: mutate_string(ciphertext, key, date, -1),
     key: key,
     date: date}
  end
end
