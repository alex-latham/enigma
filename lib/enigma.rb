require 'date'

class Enigma
  def generate_key
    key_generator = Array.new(5) { rand(9).to_s }
    key_generator.join
  end
end
