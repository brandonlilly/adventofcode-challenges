lines = File.readlines('input.txt').map(&:chomp)

boxes = lines.map do |dim|
  dim.split("x").map(&:to_i)
end

def box_wrapping_paper(w, l, h)
  sides = [l * w, w * h, h * l]
  sa = sides.reduce(0) {|total, area| total + area * 2}
  sa + sides.min
end

def ribbon_length(w, l, h)
  perimeters = [
    (w + h) * 2,
    (h + l) * 2,
    (w + l) * 2
  ]
  bow = w * l * h
  perimeters.min + bow
end

wrapping_paper_total = boxes.reduce(0) do |acc, box|
  acc + box_wrapping_paper(*box)
end

ribbon_total = boxes.reduce(0) do |acc, box|
  acc + ribbon_length(*box)
end


puts "2a: #{wrapping_paper_total}"
puts "2b: #{ribbon_total}"
