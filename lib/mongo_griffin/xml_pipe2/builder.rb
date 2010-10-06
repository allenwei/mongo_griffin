module MongoGriffin 
  module XMLPipe2
    class Builder 
      attr_reader :builder

      def initialize(*models) 
        index = models.first.defined_index
        records = models.first.all
        @builder = Nokogiri::XML::Builder.new do |xml| 
          xml.root('xmlns:sphinx' => 'sphinx') do 
            xml['sphinx'].docset do

              xml['sphinx'].schema do 
                index.fields.each do |field|
                  xml['sphinx'].field(:name => field.name) 
                end
                index.attributes.each do |attr| 
                  xml['sphinx'].attr(:name => attr.name) 
                end
                xml['sphinx'].field(:name => 'class_crc')
              end # xml['spinx'].schema do

              records.each do |record|
                xml['sphinx'].document(:id => record.sphinx_id) do 
                  xml.class_crc_ index.klass.to_crc32
                  index.fields.each do |field|
                    xml.send(field.name, record.send(field.name))
                  end
                  index.attributes.each do |attr| 
                    xml.send(attr.name, record.send(attr.name))
                  end                
                end
              end # records.each do |record|
            end
          end # xml.root do
        end
        
      end
      
      def to_xml 
        @builder.to_xml
      end  
    end
  end
end
