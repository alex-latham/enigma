require_relative 'test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
    @dictionary = {
      1=>"a", 2=>"b", 3=>"c", 4=>"d", 5=>"e", 6=>"f", 7=>"g", 8=>"h", 9=>"i",
      10=>"j", 11=>"k", 12=>"l", 13=>"m", 14=>"n", 15=>"o", 16=>"p", 17=>"q",
      18=>"r", 19=>"s", 20=>"t", 21=>"u", 22=>"v", 23=>"w", 24=>"x", 25=>"y",
      26=>"z", 27=>" "
    }
  end

  def test_it_can_exist
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    assert_equal @dictionary, @enigma.dictionary
  end

  def test_it_can_generate_a_dictionary
    assert_equal @dictionary, @enigma.generate_dictionary
  end

  def test_it_can_generate_a_key
    @enigma.stubs(:rand).with(99999).returns(923)

    assert_equal "00923", @enigma.generate_key
  end

  def test_it_can_package_keys
    @enigma.stubs(:rand).with(99999).returns(923)
    expected = {a: 0, b: 9, c: 92, d: 23}

    assert_equal expected, @enigma.package_keys
  end

  def test_it_can_generate_an_offset
    assert_equal "1025", @enigma.generate_offset("040895")

    Date.expects(:today).returns(Date.new(2000, 01, 01))

    assert_equal "0000", @enigma.generate_offset
  end



  def test_it_can_encrypt_a_message
    skip
    expected = { encryption: "keder ohulw",
                 key: "02715",
                 date: "040895" }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end
end
