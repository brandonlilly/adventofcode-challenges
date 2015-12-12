def look_and_say(seq)
  output = ''
  pos = 0
  while pos < seq.size
    char = seq[pos]
    char_count = 0
    while seq[pos] == char
      char_count += 1
      pos += 1
    end
    output += char_count.to_s + char
  end
  output
end

sequence = "1113122113"
sequence = "1"

5.times do |i|
  sequence = look_and_say(sequence)
  p formula(i)
end
puts "10a: #{sequence.length}"


10.times do |i|
  sequence = look_and_say(sequence)
end
puts "10b: #{sequence.length}"
