module Enjoy::Catalog
  module Models
    module ItemCategoryImage
      extend ActiveSupport::Concern
      # include Enjoy::Model
      # include Enjoy::Enableable

      include Enjoy::Catalog.orm_specific('ItemCategoryImage')

      included do
      end
    end
  end
end
