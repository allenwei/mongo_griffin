require 'zlib'

module MongoGriffin
  module Core
    module String
      def to_crc32
        Zlib.crc32 self
      end
    end
  end
end

class String
  include MongoGriffin::Core::String
end

