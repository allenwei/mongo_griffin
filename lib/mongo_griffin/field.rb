module MongoGriffin 
  class Field
    attr_reader :name 

    def initialize(name,options={})
      @name = name
    end

    def to_xml 
      %Q{<sphinx:field name="#{self.name}"/>}
    end

  end
end
