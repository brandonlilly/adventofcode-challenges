require 'yaml'
require('uri')

def unescape_count(str)
  str
    .gsub("\\\\", ' ')
    .gsub(/\\x\w\w/, ' ')
    .gsub("\\", '')
    .size - 2
end

def escape_count(str)
  str.inspect.size
end

lines = File.readlines('input.txt').map(&:chomp)

result = lines.reduce(0) do |count, line|
  count + line.size - unescape_count(line)
end

puts '8a', result

result = lines.reduce(0) do |count, line|
  count + escape_count(line) - line.size
end

puts '8b', result
