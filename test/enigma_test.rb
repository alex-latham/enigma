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
    key = @enigma.generate_key

    assert_instance_of String, key
    assert_equal 5, key.length
    assert key.match(/^(\d)+$/)
  end

  def test_it_can_generate_an_offset
    offset = @enigma.generate_offset("040895")

    assert_equal 1025, offset
  end
end
