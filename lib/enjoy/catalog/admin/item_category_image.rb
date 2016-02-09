module Enjoy::Catalog
  module Admin
    module ItemCategoryImage
      def self.config(fields = {})
        if block_given?
          Enjoy::Admin::EmbeddedGalleryImage.config(fields) do |config|
            yield config
          end
        else
          Enjoy::Admin::EmbeddedGalleryImage.config(fields)
        end
      end
    end
  end
end
