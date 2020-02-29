require 'date'

class Enigma
  def generate_key
    key_generator = Array.new(5) { rand(9).to_s }
    key_generator.join
  end

  def generate_offset(date_param = Date.today.strftime("%d%m%y"))
    date_squared = date_param.to_i**2
    date_squared.to_s[-4..-1]
  end
end
