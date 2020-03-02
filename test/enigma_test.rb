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
    assert_equal ({a: 10, b: 3, c: 3, d: 8}), @enigma.crack_shifts("jhql")
  end

  def test_it_can_crack_keys
    shifts = @enigma.crack_shifts("jhql")
    expected = ["08", "26", "03", "08"]

    assert_equal expected, @enigma.crack_keys("020320",shifts)
  end

  def test_it_can_normalize_keys
    skip
    shifts = @enigma.crack_shifts("jhql")
    cracked_keys = @enigma.crack_keys("020320",shifts)

    expected = {a: 8, b: 80, c: 3, d: 35}

    assert_equal expected, @enigma.normalize_keys(cracked_keys)
  end

  def test_it_can_crack
    skip
    expected = {decryption: "hello world end",
                date: "291018",
                key: "08304"}

    assert_equal expected, @enigma.crack("vjqtbeaweqihssi", "291018")

    Date.expects(:today).returns(Date.new(2018, 10, 29))
    assert_equal expected, @enigma.crack("vjqtbeaweqihssi")
  end
end
