require "rubygems"
require "bundler/setup"

require 'test/unit'
require 'shoulda'
require "ruby-debug"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'mongoid'
require 'mongo_griffin'

def setup_mongo_id

  file_name = File.join(File.dirname(__FILE__), "mongoid.yml")
  settings = YAML.load_file(file_name)

  Mongoid.configure do |config|
    config.from_hash(settings)
  end
end

setup_mongo_id

class Test::Unit::TestCase
  def setup 
    clean_mongo_db
  end

  def tear_down 
    clean_mongo_db 
  end

  def clean_mongo_db 
    MongoGriffin.clean_loaded_models
    Mongoid.database.collections.each do |collection|
      unless collection.name =~ /^system\./
        collection.remove
      end
    end
    #STDOUT.puts "finished cleaning mongodb."
  end
end
