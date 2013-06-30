require 'cloud_builder/reference'

module CloudBuilder
  class Brick
    extend Forwardable
    include ExposesRefs

    def initialize(stack, type, hash, &block)
      @stack = stack
      @type     = type
      @factory  = block
      @block = block

      @hash = DSLOpenStruct.new(hash)
      
      filename = "%s/bricks/%s.rb" % [ @stack.dirname, @type.to_s ]
      instance_eval File.read(filename), filename
    end

    def brick 
      @hash
    end

    def globals
      @stack.globals
    end
    
    def include_brick(name, hash={}, &block)
      @stack.include_brick(name, hash, &block)
    end
    
    def mappings(&block)
      @stack.mappings(&block)      
    end
    
    def parameter(name, &block)
      @stack.parameter(name, &block)
    end
    
    def resource(name, &block)
      @stack.resource(name, &block)
    end
  end
end

