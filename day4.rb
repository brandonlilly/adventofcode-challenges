require 'digest'

def stuffer(secret_key)
  md5 = Digest::MD5.new
  i = 0
  loop do
    key = secret_key + i.to_s
    hash = md5.hexdigest(key)
    works = hash.chars.first(5).all? do |char|
      char == "0"
    end

    return i if hash[0..5] == "000000"

    i += 1
  end
end

secret_key = "bgvyzdsv"

puts 'stuffer', stuffer(secret_key)
