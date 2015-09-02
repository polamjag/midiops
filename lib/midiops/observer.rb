require 'midiops/handlers'
require 'unimidi'

module MIDIOps
  class Observer
    def initialize
      @handlers = Handlers.new
    end

    def on event, &handler
      @handlers.add event, handler
    end

    def listen input
      loop do
        input.gets.each do |events|
          events[:data].each do |ev|
            @handlers.handle ev
          end
        end
      end
    end

    def listen_device device_name
      if !(dev = UniMIDI::Input.find_by_name device_name).nil?
        listen dev
      elsif !(dev = UniMIDI::Input.find { |input| input.name.include? device_name }).nil?
        listen dev
      else
        raise RuntimeError,
              "Specified device \"#{device_name}\" not available; available device(s): #{UniMIDI::Input.map{|i| '"' + i.name + '"' }.join(', ')}"
      end
    end
  end
end
