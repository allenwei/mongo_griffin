require 'helper'

class MongoidDoumentExtTest < Test::Unit::TestCase

  context "a mongoid model" do 
    setup do 
      @klass = Class.new 
      @klass.send(:include, Mongoid::Document) 
    end

    should "have class method define_index" do 
      assert @klass.respond_to?(:define_index)
    end

    context "define one index" do
      setup do 
        @klass.define_index do 
          indexes :key
        end
      end
      should "have one index instance" do  
        assert_equal :key, @klass.defined_index.fields.first.name
      end

      should "have tow indexes after define a new one" do 
        @klass.define_index do 
          indexes :key2
        end
        assert_equal 2, @klass.defined_index.fields.size
        assert_equal :key2, @klass.defined_index.fields.last.name
      end
    end

    should "support define indexes in online" do 
      @klass.define_index do 
        indexes :key,:key2
      end
      assert_equal 2, @klass.defined_index.fields.size
      assert_equal [:key,:key2], @klass.defined_index.fields.map(&:name)
    end

    context "define attribute" do  
      setup do 
        @klass.define_index do 
          has :key
        end
      end
      should "have one attribute" do  
        assert_equal :key, @klass.defined_index.attributes.first.name
      end

      should "have tow attributes" do 
        @klass.define_index do 
          has :key2
        end
        assert_equal 2, @klass.defined_index.attributes.size
        assert_equal :key2, @klass.defined_index.attributes.last.name
      end
    end
    should "support define attribute in online" do 
      @klass.define_index do 
        has :key,:key2
      end
      assert_equal 2, @klass.defined_index.attributes.size
      assert_equal [:key,:key2], @klass.defined_index.attributes.map(&:name)
    end


  end

  context "Context of MongoGriffin " do 
    should "remember the class defined index" do 
      class TestContextClass 
        include Mongoid::Document

        define_index do 
          indexes :key
        end
      end

      assert_equal TestContextClass, TestContextClass.defined_index.klass
      assert_equal TestContextClass, MongoGriffin.context.indexed_models.first
    end
  end
end

