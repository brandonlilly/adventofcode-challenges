def increment(password)
  pw_i = password
    .tr("abcdefghijklmnopqrstuvwxyz", "0123456789abcdefghijklmnopq")
    .to_i(26)

  (pw_i + 1)
    .to_s(26)
    .tr("0123456789abcdefghijklmnopq", "abcdefghijklmnopqrstuvwxyz")
    .rjust(8, 'a')
end

def straight?(str)
  count = 0
  (0...str.length - 1).each do |i|
    if (str[i+1].ord - str[i].ord) == 1
      count += 1
    else
      count = 0
    end
    return true if count == 2
  end

  false
end

def confusing?(str)
  ['i', 'o', 'l'].any? { |char| str.include?(char) }
end

def has_pairs?(str)
  pairs = {}

  (0...str.length).any? do |i|
    char, next_char = str[i], str[i + 1]
    if char == next_char
      pairs[i] = char

      pairs.keys.any? do |index|
        (index - i).abs > 1 &&  pairs[index] != char
      end
    end
  end
end

def valid?(password)
  !confusing?(password) && straight?(password) && has_pairs?(password)
end

def next_password(password)
  pw = password
  loop do
    pw = increment(pw)
    return pw if valid?(pw)
  end
end

answer = next_password("cqjxjnds")
puts "11a: #{answer}"

answer = next_password(answer)
puts "11b: #{answer}"
