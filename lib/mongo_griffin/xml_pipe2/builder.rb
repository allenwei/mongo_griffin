module MongoGriffin 
  module XMLPipe2
    class Builder 

      def initialize(indexes,records) 
        index = indexes.first
        builder = Nokogiri::XML::Builder.new do |xml| 
          xml.root do 
            xml['spinx'].docset do

              xml['spinx'].schema do 
                index.fields.each do |field|
                  xml['spinx'].field(:name => field.name) 
                end
                index.attributes.each do |attr| 
                  xml['spinx'].attr(:name => field.name) 
                end
              end # xml['spinx'].schema do



              records.each do |record|
                xml['sphinx'].document(:id => record.sphinx_id) do 
                  index.fields.each do |field|
                    xml.send(field.name, record.send(field.name))
                  end
                  index.attributes.each do |attr| 
                    xml.send(attr.name, record.send(attr.name))
                  end                
                end
              end
            end
          end
        end
      end
    end
  end
end
