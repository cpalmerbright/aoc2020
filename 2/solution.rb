require 'byebug'
require 'active_support'
require 'active_support/core_ext'

sample = true
sample = false
part_one = true
part_one = false
password_rules = File.readlines(sample ? 'sample.txt' : 'input.txt').map(&:strip)
valid_passwords = []
password_rules.each do |rule|
  count, char, password = rule.split(' ')
  min, max = count.split('-').map(&:to_i)
  char = char[0]
  if part_one
    count_in_password = password.chars.select { |character| character == char }.length
    if (min..max).include?(count_in_password)
      valid_passwords << password
    end
  else
    chars = [password.chars[min - 1], password.chars[max - 1]]
    count_in_password = chars.select { |character| character == char }.length
    valid_passwords << password if count_in_password == 1
  end
end

p valid_passwords
p valid_passwords.count

