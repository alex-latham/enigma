require_relative 'test_helper'
require './lib/decryptor'

class DecryptorTest < Minitest::Test
  def setup
    @decryptor = Decryptor.new
  end

  def test_it_can_decrypt
    expected = {decryption: 'hello world',
                key: '02715',
                date: '040895'}

    assert_equal expected, @decryptor.decrypt('keder ohulw', '02715', '040895')
  end
end
