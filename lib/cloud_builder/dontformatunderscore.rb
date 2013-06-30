require 'active_support'


module CloudBuilder
  class DontFormatUnderscore 
    def initialize(*p)
      @vars = ActiveSupport::OrderedHash.new()
      if p.first
        p.first.sort.map do |k,v|
          self[k] = v  
        end 
      end
    end
    
    def []=(key, value)
      @vars[key] = value
    end
    
    def to_json_data() 
      @vars
    end
  end
end