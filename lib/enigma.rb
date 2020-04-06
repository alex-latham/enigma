require './lib/cipher'

class Enigma < Cipher
  def generate_key
    rand(99999).to_s.rjust(5, '0')
  end

  def generate_offsets(date)
    date_squared = date.to_i**2
    offset = date_squared.to_s[-4..-1]
    offset_shifts = {a: offset[0], b: offset[1], c: offset[2], d: offset[3]}
    offset_shifts.transform_values(&:to_i)
  end

  def generate_shifts(key, date, direction)
    keys = {a: key[0..1], b: key[1..2], c: key[2..3], d: key[3..4]}
    keys.transform_values!(&:to_i)
    offsets = generate_offsets(date)
    keys.merge(offsets) do |_, key, offset|
      (key + offset) * direction
    end
  end

  def mutate_string(string, shifts)
    mutated_string = String.new
    string.each_char.with_index do |char, index|
      if @charset.include?(char)
        mutated_string += shift_charset(index, shifts)[@charset.index(char)]
      end
      mutated_string += char unless @charset.include?(char)
    end
    mutated_string
  end

  def shift_charset(index, shifts)
    return @charset.rotate(shifts[:a]) if index % 4 == 0
    return @charset.rotate(shifts[:b]) if index % 4 == 1
    return @charset.rotate(shifts[:c]) if index % 4 == 2
    return @charset.rotate(shifts[:d]) if index % 4 == 3
  end
end