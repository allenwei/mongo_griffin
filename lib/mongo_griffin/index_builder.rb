module MongoGriffin 
  class IndexBuilder 

    attr_reader :defined_index

    def self.generate!(index,&block)
      self.new(index,&block)
      index
    end

    def initialize(index,&block)
      @defined_index = index 
      self.instance_eval(&block)
    end

    def indexes(*args)
      options = args.extract_options!
      args.each do |name|
        defined_index.fields << ::MongoGriffin::Field.new(name,options)
      end
    end

    def has(*args) 
      options = args.extract_options!
      args.each do |name|
        defined_index.attributes << ::MongoGriffin::Attribute.new(name,options)
      end
    end

    def defined_index
      @defined_index ||= ::MongoGriffin::Index.new
    end

  end
end
