require 'date'
require './lib/generable'
require './lib/crackable'

class Enigma
  include Generable
  include Crackable
  attr_reader :charset

  def initialize
    @charset = ("a".."z").to_a << " "
  end

  def encrypt(plaintext, key = generate_key, date = generate_today_date)
    shifts = generate_shifts(key, date, +1)
    {encryption: mutate_string(plaintext.downcase, shifts),
     key: key,
     date: date}
  end

  def decrypt(ciphertext, key, date = generate_today_date)
    shifts = generate_shifts(key, date, -1)
    {decryption: mutate_string(ciphertext, shifts),
     key: key,
     date: date}
  end

  def crack(ciphertext, date = generate_today_date)
    shifts = crack_shifts(ciphertext)
    {decryption: mutate_string(ciphertext, shifts),
     date: date,
     key: crack_key(date, shifts)}
  end
end
