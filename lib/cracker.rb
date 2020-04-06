require './lib/enigma'

class Cracker < Enigma
  def crack(ciphertext, date = @date)
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
    seeds = calculate_seeds(date, shifts)
    seeds.each.with_index do |_, index|
      break if key_pattern?(seeds)
      until (seeds[index][1] == seeds[index + 1][0])
        seeds[index + 1] = (seeds[index + 1].to_i + 27).to_s.rjust(2, '0')
      end
    end
    seeds[0] + seeds[1][1] + seeds[2][1] + seeds[3][1]
  end

  def calculate_seeds(date, shifts)
    offsets = generate_offsets(date)
    seeds = shifts.merge(offsets) do |_, shift, offset|
      ((-shift - offset) % 27).to_s.rjust(2, '0')
    end
    seeds.values
  end

  def key_pattern?(seeds)
    seeds[0][1] == seeds[1][0] && seeds[1][1] == seeds[2][0] &&
    seeds[2][1] == seeds[3][0]
  end
end