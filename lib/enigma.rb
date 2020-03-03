require 'date'
require './lib/generable'

class Enigma
  include Generable
  attr_reader :charset

  def initialize
    @charset = ("a".."z").to_a << " "
  end
end
