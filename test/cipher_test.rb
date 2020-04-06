require_relative 'test_helper'
require './lib/decryptor'

class CipherTest < Minitest::Test
  def setup
    @cipher = Cipher.new
  end

  def test_it_can_exist
    assert_instance_of Cipher, @cipher
  end

  def test_it_has_attributes
    expected = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
      'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ' ']

    assert_equal expected, @cipher.charset
  end

  def test_it_can_generate_today_date
    Date.expects(:today).returns(Date.new(1995, 8, 4))
    assert_equal '040895', @cipher.generate_today_date
  end
end