lines = File.readlines('input.txt').map(&:chomp)

def nice?(str)
  vowels = "aeiou"
  offenders = ["ab", "cd", "pq", "xy"]
  num_vowels = 0
  contains_double = false

  (0...str.length - 1).each do |i|
    char, next_char = str[i], str[i + 1]
    char_group = str[i, 2]

    if vowels.include?(char)
      num_vowels += 1
    end

    contains_double = true if char == next_char
    return false if offenders.include?(char + next_char)
  end

  if vowels.include?(str[-1])
    num_vowels += 1
  end

  contains_double && num_vowels >= 3
end

def nice_two?(str)
  has_aba = (0...str.length - 2).any? do |i|
    str[i] == str[i+2]
  end

  pairs = {}
  has_pair = (0...str.length - 1).any? do |i|
    char, next_char = str[i], str[i+1]
    pair = str[i, 2]

    if pairs[pair]
      pair[pair] << i
    else
      pairs[pair] = [i]
    end

    pairs[pair].any? { |index| (index - i).abs > 1 }
  end

  has_aba && has_pair
end

num_nice = lines.count { |str| nice?(str) }
puts "5a: #{num_nice}"

num_nice = lines.count { |str| nice_two?(str) }
puts "5b: #{num_nice}"
