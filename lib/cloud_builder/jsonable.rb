module CloudBuilder  
  class JSONable
    def to_hash
      hash = {}
          
      self.instance_variables.each do |var|
          hash[var.to_s.delete("@")] = self.instance_variable_get var
      end
      hash
    end
    
    def to_json(*a)
        self.to_hash.to_json(*a)
    end
      
    # def from_json! string
        # JSON.load(string).each do |var, val|
            # self.instance_variable_set var, val
        # end
    # end
  end
end