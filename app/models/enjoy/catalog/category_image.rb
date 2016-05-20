if Enjoy::Catalog.config.gallery_support
  module Enjoy::Catalog
    _parent_class = Enjoy::Gallery::Image if Enjoy::Catalog.active_record?
    _parent_class = Enjoy::Gallery::EmbeddedImage if Enjoy::Catalog.mongoid?

    class CategoryImage < _parent_class
      include Enjoy::Catalog::Models::CategoryImage

      include Enjoy::Catalog::Decorators::CategoryImage

      rails_admin(&Enjoy::Catalog::Admin::CategoryImage.config(nil, rails_admin_add_fields) { |config|
        rails_admin_add_config(config)
      })
    end
  end
end
