module MongoGriffin 
  class Index
    attr_accessor :fields, :attributes, :klass

    def initialize(klass)
      @fields = []
      @attributes = []
      @klass = klass
    end

    def to_xml 
      xml = ["<sphinx:schema>"]
      (@fields + @attributes).each do |item| 
        xml << item.to_xml 
      end
      xml << "</sphinx:schema>"
      xml
    end

    def document_xml
      xml = []
      cursor = klass.collection.find
      cursor.each do |record|
        xml << %Q{<sphinx:document id="#{record.sphinx_id}">}
        xml << %Q{<class_crc>#{klass.to_crc32}</class_crc>}
        (@fields + @attributes).each do |item| 
          xml << %Q{<#{item.name}><![CDATA[[#{record.send(item.name)}]]></#{item.name}>}
        end
        xml << "</sphinx:document>"
      end
      xml
    end
  end

end
