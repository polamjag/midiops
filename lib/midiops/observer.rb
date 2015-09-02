require 'midiops/handler'
require 'unimidi'

module MIDIOps
  class Observer
    def initialize(worker_number = 1)
      @handler = Handler.new worker_number
    end

    def on event, &handler
      @handler.add event, handler
    end

    def listen input
      loop do
        input.gets.each do |events|
          events[:data].each do |ev|
            @handler.handle ev
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
