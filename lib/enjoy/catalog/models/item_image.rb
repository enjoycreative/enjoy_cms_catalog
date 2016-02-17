module Enjoy::Catalog
  module Models
    module ItemImage
      extend ActiveSupport::Concern
      # include Enjoy::Model
      # include Enjoy::Enableable

      include Enjoy::Catalog.orm_specific('ItemImage')

      included do
      end
    end
  end
end
