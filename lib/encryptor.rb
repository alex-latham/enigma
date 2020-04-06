require './lib/enigma'

class Encryptor < Enigma
  def encrypt(plaintext, key = generate_key, date = @date)
    shifts = generate_shifts(key, date, +1)
    {encryption: mutate_string(plaintext.downcase, shifts),
     key: key,
     date: date}
  end
end