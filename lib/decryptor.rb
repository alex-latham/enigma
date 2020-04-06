require './lib/enigma'

class Decryptor < Enigma
  def decrypt(ciphertext, key, date = @date)
    shifts = generate_shifts(key, date, -1)
    {decryption: mutate_string(ciphertext, shifts),
     key: key,
     date: date}
  end
end