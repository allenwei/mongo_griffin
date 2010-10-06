module MongoGriffin 
  class Attribute
    attr_reader :name 
  
    def initialize(name,options={})
      @name = name
    end
  end
end

