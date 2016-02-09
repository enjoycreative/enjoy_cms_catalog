module Enjoy::Catalog
  module Models
    module Mongoid
      module ItemImage
        extend ActiveSupport::Concern
        # include Enjoy::MongoidPaperclip

        included do
          embedded_in :item, class_name: "Enjoy::Catalog::Item"
        end


        include ::Mongoid::EmbeddedFindable
        module ClassMethods
          def find(id)
            find_through(Enjoy::Catalog::Item, 'item_images', id)
          end
        end

        def image_styles
          Enjoy::Catalog.configuration.item_images_image_styles
        end
      end
    end
  end
end
