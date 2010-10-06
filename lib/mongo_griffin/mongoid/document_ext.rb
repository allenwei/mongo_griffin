module MongoGriffin
  module DocumentExt 
    def self.included(base)
      base::ClassMethods.send(:include,ClassMethods)
      base.send(:include, InstanceMethods)
    end

    module ClassMethods 
      attr_reader :defined_index

      def define_index(&block) 
        MongoGriffin.context.indexed_models << self
        ::MongoGriffin::IndexBuilder.generate!(self.defined_index, &block)
      end

      def defined_index
        @defined_index ||= ::MongoGriffin::Index.new(self)
      end

      def to_crc32 
        self.name.to_crc32
      end
    end

    module InstanceMethods 

    end
  end
end
