require 'core_ext/hash'

module MIDIOps
  class Handler
    module Status
      HAS_HANDLER        = 0
      HANDLER_INDEFINITE = 1
      NO_HANDLERS        = 2
    end

    def initialize worker_number
      @handlers = {}
      @events = []
      @q = Queue.new
      @worker = Array.new worker_number do |i|
        Thread.start do
          while res = @q.pop
            res.call
          end
        end
      end
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
        @q.push @handlers.get_by_keys(*@events)
        @events.clear
      when Status::NO_HANDLERS
        @events.clear
      end
    end
  end
end
