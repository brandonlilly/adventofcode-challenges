people = Hash.new { |hsh, key| hsh[key] = Hash.new }

lines = File.readlines("input.txt").map(&:chomp)
lines.each do |line|
  person = line.scan(/\A(\w+) /).first
  neighbor = line.scan(/ (\w+).\z/).first
  joy = line[/\d+/].to_i
  joy = -joy if line[/lose/]

  people[person][neighbor] = joy
end

def greatest_happiness(people)
  orders = people.keys.permutation
  orders.map do |order|
    (0...order.length).reduce(0) do |acc, i|
      person, left, right = order[i], order[i - 1], order[(i+1) % order.length]
      acc + people[person][left] + people[person][right]
    end
  end.max
end

puts "13a: #{greatest_happiness(people)}"

people.keys.each do |person|
  people[person]["You"] = 0
  people["You"][person] = 0
end

puts "13b: #{greatest_happiness(people)}"
