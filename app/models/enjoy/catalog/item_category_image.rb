module Enjoy::Catalog
  class ItemCategoryImage < Enjoy::EmbeddedGalleryImage
    include Enjoy::Catalog::Models::ItemCategoryImage

    include Enjoy::Catalog::Decorators::ItemCategoryImage

    rails_admin(&Enjoy::Catalog::Admin::ItemCategoryImage.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
