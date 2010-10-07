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
          records_count = 20
          records_count.times do |index|
            People.new(:first_name => "first_name_#{index}", :last_name => "last_name_#{index}").save!
          end

          xml = ::MongoGriffin::XMLPipe2::Builder.to_xml(People)
          first_people = People.first

          assert_equal records_count, xml.scan("<sphinx:document").size, "should have #{records_count} records"
          assert_not_nil xml =~ /<sphinx:document id="#{first_people.sphinx_id}"/, "should have have first record"
          assert_not_nil xml =~ /<sphinx:field name="first_name"/, "should have field 'first_name'"
          assert_not_nil xml =~ /<sphinx:field name="last_name"/,  "should have field 'last_name'"
          assert_not_nil xml =~ /<sphinx:attr name="updated_at"/,  "should have attr 'updated_at'"
        end
      end



    end
  end
end
