module CloudBuilder
  class Output < JSONable
    include ExposesRefs
    
    def initialize(stack, &block)
      @stack   = stack
      
      @Description = ''
      @block = block
      instance_exec(&block)
    end
    
    def to_hash
      hash = super.to_hash
      hash.delete('block')
      hash
    end

    def globals
      @stack.globals
    end
    
    def to_json_data
      { "Value" => @Value, "Description" => @Description }
    end
    
    def value v
      @Value = v
    end
    
    def description value
      @Description = value
    end
    
    def brick
      @block.binding.eval('brick')
    end
    # def method_missing(field, *params)
      # instance_variable_set("@#{field}", value)
      # print @block.binding.eval('@hash')
      # null
    # end
  end
end

