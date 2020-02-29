require_relative 'test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_can_exist
    assert_instance_of Enigma, @enigma
  end

  def test_it_can_generate_a_key
    assert_instance_of String, @enigma.generate_key
    assert_equal 5, @enigma.generate_key.length
    @enigma.generate_key.each_char do |character|
      assert_instance_of Integer, character
    end
  end
end
