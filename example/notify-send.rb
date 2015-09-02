require 'midiops'
require 'unimidi'

ob = MIDIOps::Observer.new

ob.on [144, 0, 127] do
  `notify-send '#{Time.now}'`
end

ob.listen UniMIDI::Input.first.open
