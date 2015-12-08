lines = File.readlines('input.txt').map(&:chomp)

def render(grid)
  grid.transpose.map do |col|
    col.map do |cell|
      cell ? 1 : 0
    end.join(' ')
  end.join("\n")
end

def display(grid)
  puts render(grid)
end

def set_cells(grid, corner1, corner2, &prc)
  left, right = [corner1.first, corner2.first].sort
  top, bottom = [corner1.last, corner2.last].sort

  (left..right).each do |x|
    (top..bottom).each do |y|
      grid[x][y] = prc.call(grid[x][y])
    end
  end
end

def turn_on(grid, *corners)
  set_cells(grid, *corners) { |cell| cell + 1 }
end

def turn_off(grid, *corners)
  set_cells(grid, *corners) { |cell| [cell - 1, 0].max }
end

def toggle(grid, *corners)
  set_cells(grid, *corners) { |cell| cell + 2 }
end

grid = Array.new(1000) { Array.new(1000) { 0 } }

lines.each do |instruction|
  corners = instruction.scan(/\d+,\d+/).map do |coords|
    coords.split(',').map(&:to_i)
  end

  case instruction
  when /turn on/
    turn_on(grid, *corners)
  when /turn off/
    turn_off(grid, *corners)
  when /toggle/
    toggle(grid, *corners)
  else
    puts 'no match'
  end
end

total_brightness = grid.flatten.reduce { |sum, curr| sum + curr }
puts "total_brightness: #{total_brightness}"
