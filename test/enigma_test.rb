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

  def test_it_can_generate_today_date
    Date.expects(:today).returns(Date.new(1995, 8, 4))
    assert_equal "040895", @enigma.generate_today_date
  end

  def test_it_can_generate_a_key
    @enigma.stubs(:rand).returns(923)
    assert_equal "00923", @enigma.generate_key
  end

  def test_it_can_generate_offsets
    assert_equal ({a: "1", b: "0", c: "2", d: "5"}), @enigma.generate_offsets("040895")
  end

  def test_it_can_generate_shifts
    expected = {a: 3, b: 27, c: 73, d: 20}

    assert_equal expected, @enigma.generate_shifts("02715", "040895", +1)

    expected = {a: -3, b: -27, c: -73, d: -20}

    assert_equal expected, @enigma.generate_shifts("02715", "040895", -1)
  end

  def test_it_can_shift_the_charset
    shifts = {a: 3, b: 27, c: 73, d: 20}
    expected = ["t", "u", "v", "w", "x", "y", "z", " ", "a", "b", "c", "d",
                "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
                "q", "r", "s"]

    assert_equal expected, @enigma.shift_charset(14, shifts)
  end

  def test_it_can_mutate_a_string
    plaintext = "hello world"
    ciphertext = "keder ohulw"
    key = "02715"
    date = "040895"

    shifts = @enigma.generate_shifts(key, date, +1)
    assert_equal ciphertext, @enigma.mutate_string(plaintext, shifts)

    shifts = @enigma.generate_shifts(key, date, -1)
    assert_equal plaintext, @enigma.mutate_string(ciphertext, shifts)
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

  def test_it_can_crack_shifts
    ciphertext = "vjqtbeaweqihssi"
    expected = {a: 13, b: 22, c: 22, d: 19}

    assert_equal expected, @enigma.crack_shifts(ciphertext)
  end

  def test_it_can_calculate_primary_keys
    date = "291018"
    shifts = @enigma.crack_shifts("vjqtbeaweqihssi")
    expected = ["08", "02", "03", "04"]

    assert_equal expected, @enigma.calculate_primary_keys(date ,shifts)
  end

  def test_it_can_check_keys_against_key_pattern
    key1 = ["08", "80", "03", "35"]
    key2 = ["03", "04", "03", "25"]

    assert_equal true, @enigma.primary_keys_pattern?(key1)
    assert_equal false, @enigma.primary_keys_pattern?(key2)
  end

  def test_it_can_generate_cracked_key
    shifts = @enigma.crack_shifts("vjqtbeaweqihssi")

    expected = "08304"

    assert_equal expected, @enigma.crack_key("291018", shifts)
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
