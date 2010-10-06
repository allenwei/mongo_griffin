require 'helper'

module MongoGriffin 
  module XMLPipe2
    class BuilderTest < Test::Unit::TestCase 

      class People 
        include Mongoid::Document
        include Mongoid::Timestamps

        field :first_name
        field :last_name


        define_index do
          indexes :first_name, :last_name 
          has :updated_at
        end

        def sphinx_id 
          self.id
        end
      end

      context "generated sphinx xmlpipe2 xml" do 

        should "have right sphinx:schema" do 
          20.times do |index|
            People.new(:first_name => "first_name_#{index}", :last_name => "last_name_#{index}").save!
          end

          builder = ::MongoGriffin::XMLPipe2::Builder.new(People.defined_index)  
        end
      end



    end
  end
end


