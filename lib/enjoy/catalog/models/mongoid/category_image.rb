module Enjoy::Catalog
  module Models
    module Mongoid
      module CategoryImage
        extend ActiveSupport::Concern

        included do
          embedded_in :item, class_name: "Enjoy::Catalog::Category"
        end

        include ::Mongoid::EmbeddedFindable
        module ClassMethods
          def find(id)
            find_through(Enjoy::Catalog::Category, 'category_images', id)
          end
        end
      end
    end
  end
end
