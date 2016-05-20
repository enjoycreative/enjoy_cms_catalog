module Enjoy::Catalog
  class Category
    include Enjoy::Catalog::Models::Category

    include Enjoy::Catalog::Decorators::Category

    rails_admin(&Enjoy::Catalog::Admin::Category.config(rails_admin_add_fields) { |config|
      # puts config.bindings.keys
      rails_admin_add_config(config)
    })
  end
end
