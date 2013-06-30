module CloudBuilder
  module ExposesRefs
    def ref(name)
      Reference.new(name)
    end

    def base64(value)
      Reference::Base64.new(value)
    end

    def get_att(name, att)
      Reference::Attribute.new(name, att)
    end

    def join(sep, values)
      Reference::Join.new(sep, values)
    end
  end
  
  class Reference
    def initialize(name)
      @name = name
    end
    
    def to_json_data
      {REF => DSL.format(@name)}
    end

    class Base64 
      def initialize(value)
        @value = value
      end

      def to_json_data
        { BASE64 => @value }
      end
    end

    class Join
      def initialize(sep, values)
        @sep = sep
        @values = values
      end

      def to_json_data
        { JOIN => [ @sep, DSL.jsonize(@values) ]}
      end
    end

    class Attribute
      def initialize(name, att)
        @name = name
        @att = att
      end

      def to_json_data
        {GET_ATT => [DSL.format(@name), DSL.format(@att)]}
      end
    end

    class Map
      def initialize(name)
        @name = name.to_s
      end
      
      def [](key)
        Key.new(@name, [key])
      end
    end
    
    class Key
      def initialize(name, key)
        @map_name = name
        @key      = key
      end
      
      def [](subkey)
        Key.new(@map_name, @key + [subkey])
      end
      
      def to_json_data
        {FIND_IN_MAP => [DSL.format(@map_name)] + DSL.jsonize(@key)}
      end
    end
    
  end
end

