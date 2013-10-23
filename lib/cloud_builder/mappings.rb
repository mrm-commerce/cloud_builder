require 'forwardable'

module CloudBuilder
  class Mappings
    extend Forwardable
    def_delegators :@maps, :has_key?
    
    def initialize
      @maps = {}
    end
    
    def to_json_data
      json = {}
      @maps.each do |key, value|
        json[DSL.format(key)] = value
      end
      json
    end
    
    def method_missing(map_name, values)
      if @maps.has_key?(map_name.to_s)
        raise NameError('mapping %s is already defined' % map_name.to_s)
      end
      
      @maps[map_name.to_s] = values
    end
  end
end

