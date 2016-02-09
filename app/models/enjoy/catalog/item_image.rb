module Enjoy::Catalog
  class ItemImage < Enjoy::EmbeddedGalleryImage
    include Enjoy::Catalog::Models::ItemImage

    include Enjoy::Catalog::Decorators::ItemImage

    rails_admin(&Enjoy::Catalog::Admin::ItemImage.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
