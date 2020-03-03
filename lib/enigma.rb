require 'date'
require './lib/generable'

class Enigma
  include Generable
  attr_reader :charset

  def initialize
    @charset = generate_charset
  end
end
