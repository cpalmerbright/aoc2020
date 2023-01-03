require 'byebug'
require 'active_support'
require 'active_support/core_ext'

# sample = true
sample = false

lines = File.read(sample ? 'sample.txt' : 'input.txt').split("\n").map do |line|
  line.strip.split(' ')
end

acc = 0
lines_visited = []
next_line = 0

while !lines_visited.include?(next_line)
  line = lines[next_line]
  lines_visited << next_line
  val = line[1].to_i
  if line[0] == 'nop'
    next_line += 1
  elsif line[0] == 'acc'
    acc += val
    next_line += 1
  elsif line[0] == 'jmp'
    next_line += val
  end
end
puts "part one: #{acc}"

lines.length.times do |line_to_check|
  next if next_line >= lines.length
  acc = 0
  lines_visited = []
  next_line = 0

  while next_line < lines.length && !lines_visited.include?(next_line)
    line = lines[next_line]
    lines_visited << next_line
    val = line[1].to_i
    if next_line == line_to_check
      if line[0] == 'jmp'
        next_line += 1
      elsif line[0] == 'acc'
        acc += val
        next_line += 1
      elsif line[0] == 'nop'
        next_line += val
      end
    else
      if line[0] == 'nop'
        next_line += 1
      elsif line[0] == 'acc'
        acc += val
        next_line += 1
      elsif line[0] == 'jmp'
        next_line += val
      end
    end
  end
end

puts "part two: #{acc}"

