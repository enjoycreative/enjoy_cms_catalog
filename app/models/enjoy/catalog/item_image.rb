if Enjoy::Catalog.config.gallery_support
  module Enjoy::Catalog
    _parent_class = Enjoy::Gallery::Image if Enjoy::Catalog.active_record?
    _parent_class = Enjoy::Gallery::EmbeddedImage if Enjoy::Catalog.mongoid?

    class ItemImage < _parent_class
      include Enjoy::Catalog::Models::ItemImage

      include Enjoy::Catalog::Decorators::ItemImage

      rails_admin(&Enjoy::Catalog::Admin::ItemImage.config(nil, rails_admin_add_fields) { |config|
        rails_admin_add_config(config)
      })
    end
  end
end
