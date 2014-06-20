class Retrier
  def initialize(options={}, &block)
    max_tries = options.fetch(:max_tries, 10)
    rescuable = Array(options.fetch(:rescue, StandardError))
    handlers = options[:handlers]

    attempts = 0

    begin
      attempts += 1
      return block.call(attempts)
    rescue *rescuable => exception
      if handlers
        handlers.each do |ex,handler|
          handler.call(exception) if Kernel.const_get(ex) == exception.class
        end
      elsif attempts >= max_tries
        raise exception
      else
        retry
      end
    end

  end
end
