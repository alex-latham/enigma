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
      (key_shift.to_i + offset_shift.to_i) * direction
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
    shifts = crack_shifts(ciphertext)
    {decryption: mutate_string(ciphertext, shifts),
     date: date,
     key: key_generator(date, shifts)}
  end

  def crack_shifts(ciphertext)
    d_shift = (@charset.index(ciphertext[-1]) - 3) % 27
    n_shift = (@charset.index(ciphertext[-2]) - 13) % 27
    e_shift = (@charset.index(ciphertext[-3]) - 4) % 27
    space_shift = (@charset.index(ciphertext[-4]) - 26) % 27
    shift_values = [space_shift, e_shift, n_shift, d_shift]
    [:a, :b, :c, :d].zip(shift_values.rotate(ciphertext.length % 4)).to_h
  end

  def crack_keys(date, shifts)
    offsets = generate_offsets(date)
    cracked_keys = shifts.merge(offsets) do |_, shift, offset_shift|
      ((shift - offset_shift.to_i) % 27).to_s.rjust(2, "0")
    end
    cracked_keys.values
  end

  def normalize_keys(cracked_keys)
    # develop key matching pairing pattern
    require 'pry'; binding.pry


    # prelim_keys = prelim_keys.values
    # keys_string = cracked_keys.map { |key| key.to_s.rjust(2, "0") }
    #
    # prelim_keys = positive_keys.transform_values do |key|
    #   key.to_s.rjust(2, "0")
    # end
    #
    # require 'pry'; binding.pry
  end
end
