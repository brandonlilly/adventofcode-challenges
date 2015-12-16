input = "Faerun to Norrath = 129
Faerun to Tristram = 58
Faerun to AlphaCentauri = 13
Faerun to Arbre = 24
Faerun to Snowdin = 60
Faerun to Tambi = 71
Faerun to Straylight = 67
Norrath to Tristram = 142
Norrath to AlphaCentauri = 15
Norrath to Arbre = 135
Norrath to Snowdin = 75
Norrath to Tambi = 82
Norrath to Straylight = 54
Tristram to AlphaCentauri = 118
Tristram to Arbre = 122
Tristram to Snowdin = 103
Tristram to Tambi = 49
Tristram to Straylight = 97
AlphaCentauri to Arbre = 116
AlphaCentauri to Snowdin = 12
AlphaCentauri to Tambi = 18
AlphaCentauri to Straylight = 91
Arbre to Snowdin = 129
Arbre to Tambi = 53
Arbre to Straylight = 40
Snowdin to Tambi = 15
Snowdin to Straylight = 99
Tambi to Straylight = 70"

cities = Hash.new { |hsh, key| hsh[key] = Hash.new }
input.split("\n").each do |line|
  city_a, city_b, dist = line.scan(/(\w+) to (\w+) = (\d+)/).first
  dist = dist.to_i

  cities[city_a][city_b] = dist
  cities[city_b][city_a] = dist
end

routes = cities.keys.permutation.to_a
route_lengths = routes.map do |route|
  (0...route.count - 1).reduce(0) do |distance, i|
    start, dest = route[i], route[i + 1]
    distance + cities[start][dest]
  end
end

puts "9a: #{route_lengths.min}"
puts "9b: #{route_lengths.max}"
