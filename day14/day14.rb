class Racer
  attr_accessor :name, :speed, :duration, :cooldown, :score

  def initialize(name, speed, duration, cooldown)
    @name = name
    @speed = speed.to_i
    @duration = duration.to_i
    @cooldown = cooldown.to_i
    @score = 0
  end

  def position(elapsed_seconds)
    pos = 0
    counter = duration
    flying = true

    elapsed_seconds.times do |s|
      if counter == 0
        counter = flying ? cooldown : duration
        flying = !flying
      end
      counter -= 1
      pos += speed if flying
    end

    pos
  end

  def award_point
    @score += 1
  end

end

lines = File.readlines('input.txt')

racers = []
lines.each do |line|
  name, speed, duration, cooldown =
    line.scan(/(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds./)[0]

  racers << Racer.new(name, speed, duration, cooldown)
end

seconds = 2503

winning_pos = racers.map { |racer| racer.position(seconds) }.max
puts "14a: #{winning_pos}"

(1..seconds).each do |s|
  current_winner = racers.max_by { |racer| racer.position(s) }
  current_winner.award_point
end

winner_score = racers.map(&:score).max
puts "14b: #{winner_score}"
