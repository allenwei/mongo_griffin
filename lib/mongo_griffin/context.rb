module MongoGriffin
  class Context
    attr_reader :indexed_models

    def initialize(*models)
      @indexed_models = []
    end

    def clean
      @indexed_models = []
    end
  end
end
