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

  def generate_offset(date = Date.today.strftime("%d%m%y"))
    date_squared = date.to_i**2
    date_squared.to_s[-4..-1]
  end

end
