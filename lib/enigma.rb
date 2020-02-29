require 'date'

class Enigma
  def generate_key
    unpadded_key = rand(99999).to_s
    "0" * (5 - unpadded_key.length) + unpadded_key
  end

  def generate_offset(date = Date.today.strftime("%d%m%y"))
    date_squared = date.to_i**2
    date_squared.to_s[-4..-1]
  end
end
