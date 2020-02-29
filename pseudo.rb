# generate character set
("a".."z").to_a << " "

# generate keys
key_source = Array.new(5).map { rand(9).to_s }
key_a = (key_source[0] + key_source[1]).to_i
key_b = (key_source[1] + key_source[2]).to_i
key_c = (key_source[2] + key_source[3]).to_i
key_d = (key_source[3] + key_source[4]).to_i
keys = { a: key_a, b: key_b, c: key_c, d: key_d }

# generate offsets
require 'date'
date = Date.today.strftime("%d%m%y")
squared_date = date.to_i**2
offset_a = squared_date % 10000 / 1000
offset_b = squared_date % 1000 / 100
offset_c = squared_date % 100 / 10
offset_d = squared_date % 10
offsets = { a: offset_a, b: offset_b, c: offset_c, d: offset_d }

# generate shifts
shifts = keys.merge(offsets) { |_, key, offset| key + offset }
