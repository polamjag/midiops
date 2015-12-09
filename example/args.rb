require 'midiops'
require 'unimidi'

ob = MIDIOps::Observer.new

ob.on [144, 50, 127] do
  puts "PRESS NORMAL!!!!!"
end

ob.on_key 0, 'C3' do |i|
  puts "PRESS!!!!!: #{i}"
end

ob.on_key 0, 'C#3' do
  puts "press c#!!!!"
end

ob.on_pitchbend 0 do |a, b|
  puts "Pitchbend!!!: #{a}, #{b} -> #{b*128 + a}"
end

ob.listen_first
