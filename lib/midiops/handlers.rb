require 'core_ext/hash'
require 'thread'

module MIDIOps
  class Handlers
    module Status
      HAS_HANDLER        = 0
      HANDLER_INDEFINITE = 1
      NO_HANDLERS        = 2
    end

    def initialize
      @handlers = {}
      @events = []
      @threads = []
    end

    def add event, handler
      @handlers.set_by_keys event, handler
    end

    def has_handler? events
      if @handlers.keys?(*events)
        unless @handlers.get_by_keys(*events).is_a? Hash
          Status::HAS_HANDLER
        else
          Status::HANDLER_INDEFINITE
        end
      else
        Status::NO_HANDLERS
      end
    end

    def handle event
      @events << event

      case has_handler?(@events)
      when Status::HAS_HANDLER
        @handlers.get_by_keys(*@events).call
        @events.clear
      when Status::NO_HANDLERS
        @events.clear
      end
    end
  end
end
