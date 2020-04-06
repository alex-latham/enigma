require_relative 'test_helper'
require './lib/decryptor'

class CipherTest < Minitest::Test
  def setup
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    @cipher = Cipher.new
  end

  def test_it_can_exist
    assert_instance_of Cipher, @cipher
  end

  def test_it_generates_a_charset
    expected = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
      'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ']
    assert_equal expected, @cipher.charset
  end

  def test_it_generates_todays_date
    assert_equal '040895', @cipher.date
  end
end