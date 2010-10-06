module MongoGriffin
  class Configuration
    include Singleton
    
    attr_accessor :app_root
    attr_accessor :xmlpipe2_out_path
    attr_accessor :environment
    
    def initialize
      if in_rails
        self.app_root = Rails.root
      end
      
      self.app_root ||= Dir.pwd
      self.xmlpipe2_out_path ||= File.join(self.app_root,'config','xmlpipe2')
    end
    
    def self.environment
      if defined? RAILS_ENV
        RAILS_ENV
      else 
        ENV['RAILS_ENV'] || 'development'
      end
    end
    
    def in_rails?
      defined? Rails
    end
    
    def xmlpipe2_outpath_for_model(model)
      File.join(self.xmlpipe2_out_path,model.to_s.underscore,".xml")
    end
    
    
  
  end
end