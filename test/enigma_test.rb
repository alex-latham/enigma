require_relative 'test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_can_exist
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    dictionary = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
                  "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
                  "y", "z", " "]


    assert_equal dictionary, @enigma.dictionary
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

    assert_equal expected, @enigma.generate_shifts("02715", "040895", +1)

    expected = {a: -3, b: -27, c: -73, d: -20}

    assert_equal expected, @enigma.generate_shifts("02715", "040895", -1)
  end

  def test_it_can_shift_the_dictionary
    shifts = {a: 3, b: 27, c: 73, d: 20}
    expected = ["t", "u", "v", "w", "x", "y", "z", " ", "a", "b", "c", "d",
                "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
                "q", "r", "s"]

    assert_equal expected, @enigma.shifted_dictionary(14, shifts)
  end

  def test_it_can_mutate_a_string
    message = "hello world"
    cipher = "keder ohulw"
    key = "02715"
    date = "040895"

    assert_equal cipher, @enigma.mutate_string(message, key, date, +1)
    assert_equal message, @enigma.mutate_string(cipher, key, date, -1)
  end

  def test_it_can_encrypt
    expected = {encryption: "keder ohulw!",
                key: "02715",
                date: "040895"}

    assert_equal expected, @enigma.encrypt("Hello World!", "02715", "040895")

    Date.expects(:today).returns(Date.new(1995, 8, 4))
    assert_equal expected, @enigma.encrypt("hello world!", "02715")

    Date.expects(:today).returns(Date.new(1995, 8, 4))
    @enigma.stubs(:rand).returns(2715)
    assert_equal expected, @enigma.encrypt("hello world!")
  end

  def test_it_can_decrypt
    expected = {decryption: "hello world",
                key: "02715",
                date: "040895"}

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end
end
