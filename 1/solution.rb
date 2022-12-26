require 'active_support'
require 'active_support/core_ext'

sample = false
numbers = File.readlines(sample ? 'sample.txt' : 'input.txt').map(&:strip).map(&:to_i)

solution = []
numbers.each do |num|
  next if solution.present?
  numbers.each do |other|
    next if solution.present?
    numbers.each do |other_2|
      next if solution.present?

      if num + other + other_2 == 2020
        solution = [num, other, other_2]
      end
    end
  end
end

p solution
p solution.inject(:*)
