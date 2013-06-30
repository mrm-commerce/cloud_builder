module CloudBuilder
  class Parameter < JSONable
    def initialize(stack, &block)
      @stack   = stack
      
      @Type = 'String'
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
      { "Default" => @Default, "Type" => @Type }
    end
    
    def default value
      @Default = value
    end
    
    def type value
      @Type = value
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

