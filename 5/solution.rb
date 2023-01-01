require 'byebug'
require 'active_support'
require 'active_support/core_ext'

sample = true
sample = false

passes = File.read(sample ? 'sample.txt' : 'input.txt').split("\n").map do |pass|
  row = pass[0..6].chars.map { |char| char == 'F' ? 0 : 1 }.join.to_i(2)
  seat = pass[7..9].chars.map { |char| char == 'L' ? 0 : 1 }.join.to_i(2)
  row * 8 + seat
end
puts "part one: #{passes.max}"
passes = passes.sort 
missing_seat = nil
passes.sort.each_with_index do |seat, index|
  next if missing_seat.present?
  next if index == 0 || index == passes.length - 1
  next if passes[index + 1] == seat + 1

  missing_seat = seat + 1
end
puts "part two: #{missing_seat}"

# 531 too low