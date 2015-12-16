require 'json'

def sum_numbers(obj)
  return obj.to_i unless obj.is_a?(Array) || obj.is_a?(Hash)

  obj
    .map { |val| sum_numbers(val) }
    .reduce(0, :+)
end

def sum_nonred(obj)
  return obj.to_i unless obj.is_a?(Array) || obj.is_a?(Hash)
  return 0 if obj.is_a?(Hash) && obj.values.include?("red")

  obj
    .map { |val| sum_nonred(val) }
    .reduce(0, :+)
end

json = JSON.parse(File.read('input.json'))

puts "12a: #{sum_numbers(json)}"
puts "12b: #{sum_nonred(json)}"
