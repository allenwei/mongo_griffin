require 'mongo_griffin/index'
require 'mongo_griffin/attribute'
require 'mongo_griffin/field'
require 'mongo_griffin/index_builder'
require 'mongo_griffin/context'
require 'mongo_griffin/configuration'
require 'mongo_griffin/core/string'
require 'mongo_griffin/mongoid/document_ext'
require 'mongo_griffin/xml_pipe2/builder'
require 'mongoid'
require 'nokogiri'
require 'active_support'

Mongoid::Document.send(:include, MongoGriffin::DocumentExt)


module MongoGriffin 
  @@sphinx_mutex = Mutex.new
  @@context      = nil
  @@config       = nil

  def self.context 
    if @@context.nil?
      @@sphinx_mutex.synchronize do
        if @@context.nil?
          @@context = MongoGriffin::Context.new
        end
      end
    end
    @@context
  end
  def self.config
    MongoGriffin::Configuration.instance
  end

  def self.clean_loaded_models 
    self.context.clean
  end
end
