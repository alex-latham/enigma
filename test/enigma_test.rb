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
    charset = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
                  "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x",
                  "y", "z", " "]

    assert_equal charset, @enigma.charset
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

  def test_it_can_crack
    expected = {decryption: "hello world end",
                date: "291018",
                key: "08304"}

    assert_equal expected, @enigma.crack("vjqtbeaweqihssi", "291018")

    Date.expects(:today).returns(Date.new(2018, 10, 29))
    assert_equal expected, @enigma.crack("vjqtbeaweqihssi")
  end
end
