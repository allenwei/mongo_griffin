require 'helper'

module MongoGriffin 
  module Core 
    class StringTest < Test::Unit::TestCase 
      should "convert string to crc32 correctly" do 
        assert_equal 3904355907,"a".to_crc32
      end
    end
  end
end

