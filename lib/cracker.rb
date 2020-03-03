require './lib/enigma'

class Cracker < Enigma
  def crack(ciphertext, date = generate_today_date)
    shifts = crack_shifts(ciphertext)
    {decryption: mutate_string(ciphertext, shifts),
     date: date,
     key: crack_key(date, shifts)}
  end

  def crack_shifts(ciphertext)
    d_shift = (3 - @charset.index(ciphertext[-1])) % 27
    n_shift = (13 - @charset.index(ciphertext[-2])) % 27
    e_shift = (4 - @charset.index(ciphertext[-3])) % 27
    space_shift = (26 - @charset.index(ciphertext[-4])) % 27
    shift_values = [space_shift, e_shift, n_shift, d_shift]
    [:a, :b, :c, :d].zip(shift_values.rotate(-ciphertext.length % 4)).to_h
  end

  def crack_key(date, shifts)
    keys = calculate_primary_keys(date, shifts)
    keys.each.with_index do |_, index|
      break if primary_keys_pattern?(keys)
      until (keys[index][1] == keys[index + 1][0])
        keys[index + 1] = (keys[index + 1].to_i + 27).to_s.rjust(2, "0")
      end
    end
    keys[0] + keys[1][1] + keys[2][1] + keys[3][1]
  end

  def calculate_primary_keys(date, shifts)
    offsets = generate_offsets(date)
    cracked_primary_keys = shifts.merge(offsets) do |_, shift, offset|
      ((-shift - offset.to_i) % 27).to_s.rjust(2, "0")
    end
    cracked_primary_keys.values
  end

  def primary_keys_pattern?(keys)
    keys[0][1] == keys[1][0] && keys[1][1] == keys[2][0] &&
    keys[2][1] == keys[3][0]
  end
end