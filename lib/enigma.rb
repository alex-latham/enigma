require 'date'

class Enigma
  attr_reader :dictionary

  def initialize
    @dictionary = generate_dictionary
  end

  def generate_dictionary
    keys = (1..27).to_a
    values = ("a".."z").to_a << " "
    keys.zip(values).to_h
  end

  def generate_key
    unpadded_key = rand(99999).to_s
    "0" * (5 - unpadded_key.length) + unpadded_key
  end

  def generate_offset(date)
    date_squared = date.to_i**2
    date_squared.to_s[-4..-1]
  end

  def generate_shifts(key = generate_key, date = Date.today.strftime("%d%m%y"))
    keys = {a: key[0..1], b: key[1..2], c: key[2..3], d: key[3..4]}

    offset = generate_offset(date)
    offsets = {a: offset[0], b: offset[1], c: offset[2], d: offset[3]}

    keys.merge(offsets) { |_, shift, offset| shift.to_i + offset.to_i }
  end
end
