require 'midiops/handlers'

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
  end
end
