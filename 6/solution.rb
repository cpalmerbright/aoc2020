require 'byebug'
require 'active_support'
require 'active_support/core_ext'

sample = true
sample = false

groups = File.read(sample ? 'sample.txt' : 'input.txt').split("\n\n").map do |group|
  answers = group.split("\n")
  responses = answers.map(&:chars).flatten
  answer_counts = {}
  responses.map(&:chars).flatten.uniq.each do |question|
    answer_counts[question] = responses.count(question)
  end
  consensi = answer_counts.select do |question, answer_count|
    answer_count == answers.length
  end
  [answer_counts.keys.length, consensi.keys.length]
end

puts "part one: #{groups.map { |group| group[0] }.sum}"
puts "part two: #{groups.map { |group| group[1] }.sum}"

