require 'byebug'
require 'active_support'
require 'active_support/core_ext'

# file_name = 'sample.txt'
# file_name = 'big_sample.txt'
# file_name = 'custom.txt'
file_name = 'input.txt'

lines = File.read(file_name).split("\n").map do |line|
  line.strip.to_i
end

lines += [lines.max + 3, 0]
lines = lines.sort
current_rating = 0
one_volt_jumps = 0
three_volt_jumps = 0

lines.each_with_index do |jolts, index|
  diff = if index == 0
    jolts
  else
    jolts - lines[index - 1]
  end
  if diff == 1
    one_volt_jumps += 1
    current_rating += 1
  elsif diff == 3
    three_volt_jumps += 1
    current_rating += 3
  end
end

puts "part one: #{one_volt_jumps} one volt jumps * #{three_volt_jumps} three volt jumps = #{one_volt_jumps * three_volt_jumps}"

skippable_voltages = []

lines.each_with_index do |volts, index|
  next if volts == 0 || volts == lines.max

  skippable_voltages << volts if (lines[index + 1] - lines[index - 1]) <= 3
end
ranges = []
range = 1
skippable_voltages.each_with_index do |volts, index|
  next ranges << range if index == skippable_voltages.length - 1
  if skippable_voltages[index + 1] - volts == 1
    range += 1
  else
    ranges << range
    range = 1
  end
end

total = ranges.map { |range| (1..range).inject(:+) + 1 }.inject(&:*)
puts "part two: #{total}"
