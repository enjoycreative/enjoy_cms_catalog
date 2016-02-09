module Enjoy::Catalog
  class Item
    include Enjoy::Catalog::Models::Item

    include Enjoy::Catalog::Decorators::Item

    rails_admin(&Enjoy::Catalog::Admin::Item.config(rails_admin_add_fields) { |config|
      rails_admin_add_config(config)
    })
  end
end
