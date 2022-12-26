require 'byebug'
require 'active_support'
require 'active_support/core_ext'

sample = true
sample = false
part_one = true
part_one = false

map = File.readlines(sample ? 'sample.txt' : 'input.txt').map(&:strip)
all_trees = []
mod = map.first.length


# 1 down 3 across
x = 0
trees = 0
map.length.times do |index|
  mapx = x % mod
  trees += 1 if map[index][mapx] == '#'
  x += 3
end
all_trees << trees

unless part_one
  # 1 down 1 across
  x = 0
  trees = 0
  map.length.times do |index|
    mapx = x % mod
    trees += 1 if map[index][mapx] == '#'
    x += 1
  end
  all_trees << trees

  # 1 down 5 across
  x = 0
  trees = 0
  map.length.times do |index|
    mapx = x % mod
    trees += 1 if map[index][mapx] == '#'
    x += 5
  end
  all_trees << trees

  # 1 down 7 across
  x = 0
  trees = 0
  map.length.times do |index|
    mapx = x % mod
    trees += 1 if map[index][mapx] == '#'
    x += 7
  end
  all_trees << trees


  # 2 down 1 across
  x = 0
  trees = 0
  map.length.times do |index|
    next unless (index % 2 == 0)
    mapx = x % mod
    trees += 1 if map[index][mapx] == '#'
    x += 1
  end
  all_trees << trees

end
p all_trees
p all_trees.inject(&:*)
