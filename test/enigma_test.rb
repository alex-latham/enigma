require_relative 'test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_can_exist
    assert_instance_of Enigma, @enigma
  end

  def test_it_can_generate_offsets
    expected = {a: 1, b: 0, c: 2, d: 5}

    assert_equal expected, @enigma.generate_offsets('040895')
  end

  def test_it_can_generate_a_key
    @enigma.stubs(:rand).returns(923)
    assert_equal '00923', @enigma.generate_key
  end

  def test_it_can_generate_shifts
    expected = {a: 3, b: 27, c: 73, d: 20}

    assert_equal expected, @enigma.generate_shifts('02715', '040895', +1)

    expected = {a: -3, b: -27, c: -73, d: -20}

    assert_equal expected, @enigma.generate_shifts('02715', '040895', -1)
  end

  def test_it_can_shift_the_charset
    shifts = {a: 3, b: 27, c: 73, d: 20}
    expected = ['t', 'u', 'v', 'w', 'x', 'y', 'z', ' ', 'a', 'b', 'c', 'd',
                'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
                'q', 'r', 's']

    assert_equal expected, @enigma.shift_charset(14, shifts)
  end

  def test_it_can_mutate_a_string
    plaintext = 'hello world'
    ciphertext = 'keder ohulw'
    key = '02715'
    date = '040895'

    shifts = @enigma.generate_shifts(key, date, +1)
    assert_equal ciphertext, @enigma.mutate_string(plaintext, shifts)

    shifts = @enigma.generate_shifts(key, date, -1)
    assert_equal plaintext, @enigma.mutate_string(ciphertext, shifts)
  end
end
