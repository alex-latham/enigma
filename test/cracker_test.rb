require_relative 'test_helper'
require './lib/cracker'

class CrackerTest < Minitest::Test
  def setup
    Date.expects(:today).returns(Date.new(2018, 10, 29))
    @cracker = Cracker.new
  end

  def test_it_can_exist
    assert_instance_of Cracker, @cracker
  end

  def test_it_can_crack
    expected = {decryption: 'hello world end',
                date: '291018',
                key: '08304'}

    assert_equal expected, @cracker.crack('vjqtbeaweqihssi', '291018')
    assert_equal expected, @cracker.crack('vjqtbeaweqihssi')
  end

  def test_it_can_crack_shifts
    ciphertext = 'vjqtbeaweqihssi'
    expected = {a: 13, b: 22, c: 22, d: 19}

    assert_equal expected, @cracker.crack_shifts(ciphertext)
  end

  def test_it_can_calculate_seeds
    date = '291018'
    shifts = @cracker.crack_shifts('vjqtbeaweqihssi')
    expected = ['08', '02', '03', '04']

    assert_equal expected, @cracker.calculate_seeds(date, shifts)
  end

  def test_it_can_check_seeds_against_the_key_pattern
    seeds1 = ['08', '80', '03', '35']
    seeds2 = ['03', '04', '03', '25']

    assert_equal true, @cracker.key_pattern?(seeds1)
    assert_equal false, @cracker.key_pattern?(seeds2)
  end

  def test_it_can_crack_a_key
    shifts = @cracker.crack_shifts('vjqtbeaweqihssi')
    expected = '08304'

    assert_equal expected, @cracker.crack_key('291018', shifts)
  end
end
