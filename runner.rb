require './lib/enigma'

enigma = Enigma.new

message = " end"
encrypted = enigma.encrypt(message, "08035", "020320")
actual_shifts = enigma.generate_shifts("08035", "020320", +1)
cracked_shifts = enigma.crack_shifts(encrypted[:encryption])
offsets = enigma.generate_offsets("020320")
actual_keys = actual_shifts.merge(offsets)do |_, shift, offset_shift|
  (shift - offset_shift.to_i).to_s.rjust(2, "0")
end

preliminary_keys = cracked_shifts.merge(offsets) do |_, shift, offset_shift|
  ((shift - offset_shift.to_i) % 27).to_s.rjust(2, "0")
end
require 'pry'; binding.pry
