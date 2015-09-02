require 'midiops'
require 'unimidi'

ob = MIDIOps::Observer.new 3

ob.on [144, 48, 127] do
  `say Hello`
end

ob.listen_device 'Launchpad S'
