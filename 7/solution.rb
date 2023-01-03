require 'byebug'
require 'active_support'
require 'active_support/core_ext'

sample = true
sample = false

class Bag
  def self.all
    @all
  end
  def self.all=(bags)
    @all = bags
  end

  def self.find_by_colour(colour)
    all.find { |bag| bag.colour == colour }
  end

  def initialize(colour, contents)
    @colour = colour
    @empty = contents == ['no other']
    return if @empty

    @contents = contents.map do |content|
      content = content.split(' ', 2)
      content[0] = content[0].to_i
      content
    end
  end

  attr_accessor :colour, :empty, :contents, :bags_inside

  def set_bags_inside
    return if @empty

    @bags_inside = @contents.map do |content|
      self.class.find_by_colour(content[1])
    end
  end

  def number_of_bags_inside
    return @number_of_bags_inside unless @number_of_bags_inside.nil?
    @number_of_bags_inside = 0
    return @number_of_bags_inside if empty

    contents.each_with_index do |bag, index|
      @number_of_bags_inside += (bag[0] * (1 + @bags_inside[index].number_of_bags_inside))
    end

    @number_of_bags_inside
  end

  def can_contain_gold
    return @can_contain_gold unless @can_contain_gold.nil? 
    return @can_contain_gold = false if empty

    @can_contain_gold = bags_inside.any? { |bag| bag.colour == 'shiny gold' || bag.can_contain_gold }
  end
end

bags = File.read(sample ? 'sample.txt' : 'input.txt').split("\n").map do |rule|
  rule = rule.strip.gsub('bags', 'bag').gsub(',', '').gsub('.', '').gsub('contain', '').split('bag').map(&:strip)
  Bag.new(rule[0], rule[1..-1])
end
Bag.all = bags
Bag.all.each(&:set_bags_inside)

part_one = bags.select { |bag| bag.can_contain_gold }.length
puts "part one: #{part_one}"
shiny_gold_bag = Bag.find_by_colour('shiny gold')

puts "part two: #{shiny_gold_bag.number_of_bags_inside}"

