require 'midiops'
require 'unimidi'

ob = MIDIOps::Observer.new

ob.on [144, 0, 127] do
  `say Hello`
end

ob.listen UniMIDI::Input.first.open
