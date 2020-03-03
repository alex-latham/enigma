require_relative 'test_helper'
require './lib/encryptor'

class EncryptorTest < Minitest::Test
  def setup
    @encryptor = Encryptor.new
  end

  def test_it_can_encrypt
    expected = {encryption: "keder ohulw!",
                key: "02715",
                date: "040895"}

    assert_equal expected, @encryptor.encrypt("Hello World!", "02715", "040895")

    @encryptor.stubs(:generate_today_date).returns("040895")
    assert_equal expected, @encryptor.encrypt("hello world!", "02715")

    @encryptor.stubs(:generate_today_date).returns("040895")
    @encryptor.stubs(:generate_key).returns("02715")
    assert_equal expected, @encryptor.encrypt("hello world!")
  end
end
