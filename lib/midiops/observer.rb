require 'midiops/handler'
require 'midiops/note'
require 'eventmachine'

require 'unimidi'

module MIDIOps
  class Observer
    def initialize(worker_number = 1)
      @handler = Handler.new worker_number
    end

    def on event, &handler
      @handler.add event, handler
    end

    def on_cc ch, number, &handler
      @handler.add [176+ch, number, :ARG], handler
    end

    def on_key_press ch, note_string, &handler
      @handler.add [144+ch, MIDIOps::Note.note_to_code(note_string), :ARG], handler
    end
    alias_method :on_key, :on_key_press

    def on_key_release ch, key, octave, &handler
      @handler.add [128+ch, MIDIOps::Note.note_to_code(note_string), :ARG], handler
    end

    def listen input
      EM.run do
        loop do
          input.gets.each do |events|
            events[:data].each do |ev|
              @handler.handle ev
            end
          end
        end
      end
    end

    def listen_device device_name
      if !(dev = UniMIDI::Input.find_by_name device_name).nil?
        listen dev.open
      elsif !(dev = UniMIDI::Input.find { |input| input.name.include? device_name }).nil?
        listen dev.open
      else
        raise RuntimeError,
              "Specified device \"#{device_name}\" not available; available device(s): #{UniMIDI::Input.map{|i| '"' + i.name + '"' }.join(', ')}"
      end
    end

    def listen_first
      listen UniMIDI::Input.first.open
    end
  end
end
