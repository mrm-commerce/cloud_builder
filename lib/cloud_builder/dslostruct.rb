require 'ostruct'

module CloudBuilder
  class DSLOpenStruct < OpenStruct
    
    def ref(name)
      Reference.new(name)
    end

    def get_att(name, att)
      Reference::Attribute.new(name, att)
    end
    
    def method_missing(mid, *args)
      mname = mid.id2name
      len = args.length
      if mname.chomp!('=')
        if len != 1
          raise ArgumentError, "wrong number of arguments (#{len} for 1)", caller(1)
        end
        modifiable[new_ostruct_member(mname)] = args[0]
      elsif len == 0
        if @table.has_key? mid
          @table[mid]
        else
          raise NameError, "undefined property #{mid} for #{self}", caller(1)
        end
      else
        raise NoMethodError, "undefined method `#{mid}' for #{self}", caller(1)
      end
    end
  end
end