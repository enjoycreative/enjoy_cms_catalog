module Enjoy::Catalog
  module Models
    module Mongoid
      module ItemCategoryImage
        extend ActiveSupport::Concern
        # include Enjoy::MongoidPaperclip

        included do
          embedded_in :item, class_name: "Enjoy::Catalog::ItemCategory"
        end

        include ::Mongoid::EmbeddedFindable
        module ClassMethods
          def find(id)
            find_through(Enjoy::Catalog::ItemCategory, 'item_category_images', id)
          end
        end

        def image_styles
          Enjoy::Catalog.configuration.item_category_images_image_styles
        end

        def image_jcrop_options
          {}
        end
      end
    end
  end
end
