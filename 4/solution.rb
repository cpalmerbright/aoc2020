require 'byebug'
require 'active_support'
require 'active_support/core_ext'

sample = true
sample = false

@expected_fields = [
  'byr',
  'iyr',
  'eyr',
  'hgt',
  'hcl',
  'ecl',
  'pid'
]

def valid(fields)
  @expected_fields.each do |field|
    return false unless fields.keys.include?(field)
  end
  true
end

def valid_part_two(fields)
  return false unless fields['byr'].present? && fields['byr'].to_i.between?(1920, 2002) 
  return false unless fields['iyr'].present? && fields['iyr'].to_i.between?(2010, 2020) 
  return false unless fields['eyr'].present? && fields['eyr'].to_i.between?(2020, 2030)
  return false unless fields['hgt'].present?
  if fields['hgt'].include?('cm')
    return false unless fields['hgt'].split('cm')&.first.to_i.between?(150, 193)
  elsif fields['hgt'].include?('in')
    return false unless fields['hgt'].split('in')&.first.to_i.between?(59, 76)
  else
    return false
  end
  return false unless fields['hcl']&.length == 7 && fields['hcl'][0] == '#'
  return false unless fields['hcl'].chars[1..7].all? { |char| ('0'..'9').to_a.include?(char) || ('a'..'f').to_a.include?(char) }
  return false unless fields['ecl'].present? && ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(fields['ecl'])
  return false unless fields['pid'].present? && fields['pid'].length == 9 && fields['pid'].chars.all? { |char| ('0'..'9').to_a.include?(char) }
  true
end

passports = File.read(sample ? 'sample.txt' : 'input.txt').split("\n\n").map do |passport|
  fields = passport.split(' ').map { |field| field.split(':')}.to_h
  [fields, valid(fields), valid_part_two(fields)]
end

# p passports.first
# p passports.second

p passports.select { |passport| !!passport[1] }.count
p passports.select { |passport| !!passport[2] }.count
