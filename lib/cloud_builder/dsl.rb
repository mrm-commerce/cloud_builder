require 'active_support'

module CloudBuilder

  module DSL
    
    attr_accessor :globals

    def globals 
      @globals ||= DSLOpenStruct.new()
    end

    def self.format(key)
      key.to_s.gsub(/(.)[_-](.)/) { $1 + $2.upcase }.gsub(/^(.)/) { $1.upcase }
    end
    
    def self.hashize(value, format_hash_keys = true)
      case value
        when Array then value.map { |v| jsonize v,format_hash_keys }
        when Hash then 
          ret = {}
          value.each do |k,v|
            if format_hash_keys
              ret[DSL.format(k)] = jsonize v,format_hash_keys
            else
              ret[k] = jsonize v,format_hash_keys
            end
          end
          ret
        else
          value.respond_to?(:to_json_data) ? value.to_json_data : value
      end
    end

    def self.jsonize(value, format_hash_keys = true)
      ret = self.hashize(value, format_hash_keys)
      case ret
        when Hash then  
          sh = ActiveSupport::OrderedHash.new
          ret.sort.map do |k,v|
            sh[k] =v
          end
          sh
        else
          ret
      end
    end
    
    def mappings(&block)
      _mappings.instance_eval(&block)
    end
    
    def resource(name, &block)
      if _resources.has_key?(name.to_s)
        raise NameError('resource %s is already defined' % name.to_s)
      end
      
      _resources[name.to_s] = Resource.new(self, name, &block)
    end
    
    def include_brick(name, hash={}, &block)
      _bricks[name.to_s] = Brick.new(self, name, hash, &block)
    end
    
    def parameter(name, &block)
      if _parameters.has_key?(DSL.format(name.to_s))
        raise NameError('parameter %s is already defined' % name.to_s)
      end
      
      _parameters[DSL.format(name.to_s)] = Parameter.new(self, &block)
    end
    
    def output(name, &block)
      if _outputs.has_key?(DSL.format(name.to_s))
        raise NameError('output %s is already defined' % name.to_s)
      end
      
      _outputs[DSL.format(name.to_s)] = Output.new(self, &block)
    end
    
    def to_json
      JSON.pretty_generate(DSL.jsonize(generate_spec, false))
    end
    
    def reference_type(name)
      if _parameters.has_key?(name)
        :parameter
      elsif _mappings.has_key?(name)
        :map
      elsif _resources.has_key?(name)
        :resource
      end
    end
    
    def dirname 
      @dirname
    end
    
    def method_missing(field, value)
      instance_variable_set("@#{field}", value)
    end
    
  private
    
    def generate_spec
      spec = {
        DESCRIPTION => @description,
        VERSION     => @template_version,
        MAPPINGS    => DSL.jsonize(_mappings),
        RESOURCES   => {},
        PARAMETERS  => {},
        OUTPUTS     => {},
      }
      _resources.each do |name, instance|
        spec[RESOURCES][DSL.format(name)] = DSL.jsonize(instance)
      end
      
      _parameters.each do |name, parameter|
        spec[PARAMETERS][name] = DSL.jsonize(parameter)  
      end
      
      _outputs.each do |name, parameter|
        spec[OUTPUTS][name] = DSL.jsonize(parameter)  
      end
      
      spec
    end
    
    def _mappings
      @mappings ||= Mappings.new
    end
    
    def _resources
      @resources ||= {}
    end
    
    def _bricks
      @bricks ||= {}
    end
    
    def _parameters
      @parameters ||= {}
    end
    
    def _outputs
      @outputs ||= {}
    end
  end
end

