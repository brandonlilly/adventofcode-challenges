lines = File.readlines('input.txt').map(&:chomp)

wires = lines.reduce({}) do |wires, line|
  feed, output = line.split(" -> ")
  wires[output] = feed
  wires
end

$cache = {}

def get_signal(wires, wire)
  feed = wires[wire]

  return wire.to_i if wire =~ /\A\d+\z/
  return feed.to_i if feed =~ /\A\d+\z/
  return $cache[wire] if $cache[wire]

  operators = ["AND", "OR", "LSHIFT", "RSHIFT", "NOT"]
  inputs = operators
    .reduce(feed) do |acc, op|
      acc.sub(op, '')
    end
    .split(" ")
    .map do |input|
      get_signal(wires, input)
    end

  a, b = inputs

  result = case feed
  when /\w+ LSHIFT \d+/
    a << b
  when /\w+ RSHIFT \d+/
    a >> b
  when /NOT \w+/
    65536 + ~a
  when /\w+ AND \w+/
    a & b
  when /\w+ OR \w+/
    a | b
  when /\w+/
    a
  else
    puts "no match: #{feed}"
  end

  $cache[wire] = result
  result
end

a = get_signal(wires, 'a')
puts "(7a) a = #{a}"

$cache = {}
wires['b'] = a.to_s
a2 = get_signal(wires, 'a')
puts "(7b) a = #{a2}"
