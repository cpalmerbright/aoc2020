require 'byebug'
require 'active_support'
require 'active_support/core_ext'

sample = true
# sample = false

lines = File.read(sample ? 'sample.txt' : 'input.txt').split("\n").map do |line|
  line.strip
end

puts "part one: #{'part_one'}"
puts "part two: #{'part_two'}"

