module CloudBuilder
  class Stack
    include DSL
    include ExposesRefs

    def initialize filename
      @dirname = File.dirname(File.expand_path(filename))
      instance_eval File.read(filename), filename
    end

  end
end