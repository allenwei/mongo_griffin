require 'helper'

class TestConfiguration < Test::Unit::TestCase
  context "enviroment" do
    should "equal RAILS_ENV if it has" do
      RAILS_ENV = "test_rails_env"
      assert_equal("test_rails_env", MongoGriffin::Configuration.environment)
    end

    should "equal RAILS_ENV if it has" do
      ENV['RAILS_ENV'] = "test_rails_env"
      assert_equal("test_rails_env", MongoGriffin::Configuration.environment)
    end

    should "be development by default" do
      assert_equal("development", MongoGriffin::Configuration.environment)
    end

  end
end
