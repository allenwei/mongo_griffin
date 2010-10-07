module MongoGriffin 
  class Attribute
    attr_reader :name 

    def initialize(name,options={})
      @name = name
    end

    def to_xml 
      %Q{<sphinx:attr name="#{self.name}"/>}
    end

  end
end

