module Enjoy::Catalog
  module Models
    module CategoryImage
      extend ActiveSupport::Concern
      # include Enjoy::Model
      # include Enjoy::Enableable

      include Enjoy::Catalog.orm_specific('CategoryImage')

      included do
      end

      def image_styles
        Enjoy::Catalog.configuration.category_images_image_styles
      end
    end
  end
end
