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

  def crack(ciphertext, date = generate_today_date)
    # shif ["x", "x", "x", "x"] length 4 => d_char_modulus 0
    # orig [" ", "e", "n", "d"]
    # indx [ -4,  -3,  -2,  -1]
    d_shift = @charset.index(ciphertext[-1]) - 3
    n_shift = @charset.index(ciphertext[-2]) - 13
    e_shift = @charset.index(ciphertext[-3]) - 4
    space_shift = @charset.index(ciphertext[-3]) - 27
    shift_values = [space_shift, e_shift, n_shift, d_shift]
    shift_keys = [:a, :b, :c, :d]
    if ciphertext.length % 4  == 0
      shifts = shift_keys.zip(shift_values).to_h
      # shift_d = d_shift
      # shift_c = n_shift
      # shift_b = e_shift
      # shift_a = space_shift
    elsif last_index % 4 == 1
      shifts = shift_keys.zip(shift_values.rotate).to_h
      # shift_a = d_shift
      # shift_d = n_shift
      # shift_c = e_shift
      # shift_b = space_shift
    elsif last_index % 4 == 2
      # shift_b = d_shift
      # shift_a = n_shift
      # shift_d = e_shift
      # shift_c = space_shift
    elsif last_index % 4 == 2
      # shift_c = d_shift
      # shift_b = n_shift
      # shift_a = e_shift
      # shift_d = space_shift
  end
end
