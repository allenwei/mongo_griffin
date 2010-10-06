module MongoGriffin 
  class Index
    attr_accessor :fields, :attributes, :klass
  
    def initialize(klass)
      @fields = []
      @attributes = []
      @klass = klass
    end
  end
end
