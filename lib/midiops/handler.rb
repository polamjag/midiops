require 'core_ext/hash'
require 'eventmachine'

module MIDIOps
  class Handler
    module Status
      NO_HANDLERS          = 0

      HAS_HANDLER          = 1 # just have handler with current @events
      HAS_HANDLER_WITH_ARG = 2 # have handler w/ current @events but last is :ARG

      HANDLER_INDEFINITE   = 3
      WAITING_ARG          = 4 # HANDLER_INDEFINITE but current event is :ARG
    end

    def initialize
      @handlers     = {}
      @events       = [] # pool for events not processed
      @handler_args = [] # args to pass to handler method
    end

    def add event, handler
      @handlers.set_by_keys event, handler
    end

    def status
      if @handlers.get_by_keys(*@events).is_a? Proc
        Status::HAS_HANDLER
      elsif @handlers.get_by_keys(*(@events.take(@events.size - 1)), :ARG).is_a? Proc
        Status::HAS_HANDLER_WITH_ARG
      elsif @handlers.get_by_keys(*(@events.take(@events.size - 1)), :ARG).is_a? Hash
        Status::WAITING_ARG
      elsif @handlers.get_by_keys(*@events).is_a? Hash
        Status::HANDLER_INDEFINITE
      elsif @handlers.get_by_keys(*@events).nil?
        Status::NO_HANDLERS
      else
        raise RuntimeError, "Invalid handler status: #{self.inspect}"
      end
    end

    def defer handler, args=[]
      EM.defer(Proc.new { handler.call(*args) }) unless handler.nil?
    end

    def clear_state
      @events.clear
      @handler_args.clear
    end

    def handle event
      @events << event

      case status
      when Status::HAS_HANDLER
        defer @handlers.get_by_keys(*@events, event), @handler_args.dup
        clear_state
      when Status::HAS_HANDLER_WITH_ARG
        @handler_args << event
        @events.pop
        @events << :ARG
        defer(
          @handlers.get_by_keys(*@events),
          @handler_args.dup
        )
        clear_state
      when Status::WAITING_ARG
        @handler_args << event
        @events.pop
        @events << :ARG
      when Status::NO_HANDLERS
        clear_state
      when Status::HANDLER_INDEFINITE
      end
    end
  end
end
