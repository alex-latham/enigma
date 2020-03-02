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

  def generate_offsets(date)
    date_squared = date.to_i**2
    offset = date_squared.to_s[-4..-1]
    {a: offset[0], b: offset[1], c: offset[2], d: offset[3]}
  end

  def generate_shifts(key, date, direction)
    keys = {a: key[0..1], b: key[1..2], c: key[2..3], d: key[3..4]}
    offsets = generate_offsets(date)
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

  def mutate_string(string, shifts)
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
    shifts = generate_shifts(key, date, +1)
    {encryption: mutate_string(plaintext.downcase, shifts),
     key: key,
     date: date}
  end

  def decrypt(ciphertext, key, date = generate_today_date)
    shifts = generate_shifts(key, date, -1)
    {decryption: mutate_string(ciphertext, shifts),
     key: key,
     date: date}
  end

  def crack(ciphertext, date = generate_today_date)
    offsets = generate_offsets(date)
    shifts = crack_shifts(ciphertext)
    {decryption: mutate_string(ciphertext, shifts),
     key: key_generator(date, shifts),
     date: date}
  end

  def crack_shifts(ciphertext)
    d_shift = 3 - @charset.index(ciphertext[-1])
    n_shift = 13 - @charset.index(ciphertext[-2])
    e_shift = 4 - @charset.index(ciphertext[-3])
    space_shift = 26 - @charset.index(ciphertext[-4])
    shift_values = [space_shift, e_shift, n_shift, d_shift]
    shift_keys = [:a, :b, :c, :d]
    index_positions = ciphertext.length - 1
    rotations = ciphertext.length
    shift_keys.zip(shift_values.rotate(rotations)).to_h
  end

  def key_generator(date, shifts)
    shifts = shifts.merge(offsets) do |_, shift, offset|
      shift.to_i - offset.to_i
    end
  end
end
