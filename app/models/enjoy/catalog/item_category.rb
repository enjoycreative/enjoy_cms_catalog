module Enjoy::Catalog
  class ItemCategory
    include Enjoy::Catalog::Models::ItemCategory

    include Enjoy::Catalog::Decorators::ItemCategory

    rails_admin &Enjoy::Catalog::Admin::ItemCategory.config
  end
end
