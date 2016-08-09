module Enjoy::Catalog
  module Models
    module ItemImage
      extend ActiveSupport::Concern
      # include Enjoy::Model
      # include Enjoy::Enableable

      include Enjoy::Catalog.orm_specific('ItemImage')

      included do
      end

      def image_styles
        Enjoy::Catalog.configuration.item_images_image_styles
      end
    end
  end
end
