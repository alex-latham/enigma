require_relative 'test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
    @dictionary = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
                   "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
                   "y", "z", " "]
  end

  def test_it_can_exist
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    assert_equal @dictionary, @enigma.dictionary
  end

  def test_it_can_generate_a_key
    @enigma.stubs(:rand).returns(923)
    assert_equal "00923", @enigma.generate_key
  end

  def test_it_can_generate_an_offset
    assert_equal "1025", @enigma.generate_offset("040895")
  end

  def test_it_can_generate_shifts
    expected = {a: 3, b: 27, c: 73, d: 20}

    assert_equal expected, @enigma.generate_shifts("02715", "040895")
  end

  def test_it_can_find_shifted_character_indices
    shifts = {a: 3, b: 27, c: 73, d: 20}

    assert_equal 10, @enigma.shifted_char_index("h", 0, shifts)
  end

  def test_it_can_encrypt
    expected = {encryption: "keder ohulw",
                key: "02715",
                date: "040895"}

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
    # Date.expects(:today).returns(Date.new(2015, 04, 17))
  end
end
