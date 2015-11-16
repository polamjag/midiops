require 'core_ext/hash'
require 'eventmachine'

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
      @waiting_param = false
    end

    def push_job job
    end

    def add event, handler
      @handlers.set_by_keys event, handler
    end

    def has_handler?
      if @handlers.keys?(*@events).nil?
        Status::NO_HANDLERS
      elsif @handlers.get_by_keys(*@events).is_a? Hash
        @waiting_param = true unless @handlers.get_by_keys(*@events)[:ARG].nil?
        Status::HANDLER_INDEFINITE
      else
        Status::HAS_HANDLER
      end
    end

    def handle event
      if @waiting_param
        prc = @handlers.get_by_keys(*@events)[:ARG]
        EM.defer(Proc.new { prc.call(event) })

        @events.clear
        @waiting_param = false
      else
        @events << event

        case has_handler?
        when Status::HAS_HANDLER
          EM.defer(@handlers.get_by_keys(*@events)) unless @handlers.get_by_keys(*@events).nil?

          @events.clear
        when Status::NO_HANDLERS
          @events.clear
        when Status::HANDLER_INDEFINITE
          # do nothing
        end
      end
    end
  end
end
