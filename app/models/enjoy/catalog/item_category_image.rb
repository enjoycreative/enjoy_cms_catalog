module Enjoy::Catalog
  class ItemCategoryImage < Enjoy::EmbeddedGalleryImage
    include Enjoy::Catalog::Models::ItemCategoryImage

    include Enjoy::Catalog::Decorators::ItemCategoryImage

    rails_admin &Enjoy::Catalog::Admin::ItemCategoryImage.config
  end
end
