require 'fileutils'

namespace :mongo_griffin do
  task :app_env do
    if defined?(RAILS_ROOT)
      Rake::Task[:environment].invoke
      
      if defined?(Rails.configuration)
        Rails.configuration.cache_classes = false
      else
        Rails::Initializer.run { |config| config.cache_classes = false }
      end
    end
  end
  
  task :gen_xmlpipe2 do 
    MongoGriffin.context.indexed_models.each do |model|
      builder = MongoGriffin::XMLPipe2::Builder.new(model.defined_index, model.all)
      FileUtils.mkdir_p MongoGriffin.config.xmlpipe2_out_path
      File.open(MongoGriffin.config.xmlpipe2_outpath_for_model(model),"w+") do |f|
        f.puts builder.to_xml
      end
    end
  end
end