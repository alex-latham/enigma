require_relative 'test_helper'
require './lib/enigma'

class CrackableTest < Minitest::Test
  def setup
    @enigma = Enigma.new
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
end