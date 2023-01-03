require 'byebug'
require 'active_support'
require 'active_support/core_ext'

sample = true
sample = false

@lines = File.read(sample ? 'sample.txt' : 'input.txt').split("\n").map(&:strip).map(&:to_i)

preamble = sample ? 5 : 25
first_invalid_number = nil

@lines.each_with_index do |line, index|
  next if first_invalid_number.present? || index < preamble

  sum_found = false

  first_line_to_check = [0, index - preamble].max
  @lines[first_line_to_check..(index - 1)].each_with_index do |x, x_index|
    break if sum_found

    @lines[(first_line_to_check + x_index + 1)..(index - 1)].each do |y|
      sum_found = (x + y) == line
      break if sum_found
    end
  end
  
  break first_invalid_number = line unless sum_found
end

puts "part one: #{first_invalid_number}"

@contigious_numbers = []
@lines.each_with_index do |line, index|
  next if @contigious_numbers.present?
  sum = line
  range = 1
  while sum < first_invalid_number
    sum += @lines[index + range]
    range += 1
  end

  contigious_range = @lines[index..(index + range - 1)]
  break @contigious_numbers = [contigious_range.min, contigious_range.max] if sum == first_invalid_number
end

puts "part two: #{@contigious_numbers[0]} + #{@contigious_numbers[1]} == #{@contigious_numbers.sum}"

