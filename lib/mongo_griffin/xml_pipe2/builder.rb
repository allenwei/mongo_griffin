module MongoGriffin 
  module XMLPipe2
    class Builder 
      attr_reader :index

      def self.to_xml(model) 
        index = model.defined_index
        xml = [%Q{<?xml version="1.0" encoding="utf-8"?>}]
        xml << %Q{<sphinx:docset>}
        xml += index.to_xml
        xml += index.document_xml
        xml << %Q{</sphinx:docset>}
        xml.join("\n")
      end

    end
  end
end
