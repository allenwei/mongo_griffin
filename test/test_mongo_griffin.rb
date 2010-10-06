require 'helper'

class TestMongoGriffin < Test::Unit::TestCase

  context "MongoGriffin" do 
    should "init context" do 
      assert_not_nil MongoGriffin.context
    end
  end
end
