# generate character set
("a".."z").to_a << " "

# random number generator
key = Array.new(5).map { rand(9) }

# generate current date
require 'date'
date = Date.today.strftime("%d%m%y")
