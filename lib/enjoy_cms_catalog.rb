require "enjoy/catalog/version"

require 'enjoy/catalog/routes'

require 'money-rails'

require 'enjoy_cms'

require 'rails_admin_sort_embedded'
require 'rails_admin_jcrop'

require 'enjoy/catalog/configuration'
require 'enjoy/catalog/engine'

module Enjoy
  module Catalog
    class << self
      def orm
        :mongoid
      end
      def mongoid?
        Enjoy::Catalog.orm == :mongoid
      end
      def active_record?
        Enjoy::Catalog.orm == :active_record
      end
      def model_namespace
        "Enjoy::Catalog::Models::#{Enjoy::Catalog.orm.to_s.camelize}"
      end
      def orm_specific(name)
        "#{model_namespace}::#{name}".constantize
      end
    end

    autoload :Admin,  'enjoy/catalog/admin'
    module Admin
      autoload :Item,               'enjoy/catalog/admin/item'
      autoload :ItemCategory,       'enjoy/catalog/admin/item_category'
      autoload :ItemImage,          'enjoy/catalog/admin/item_image'
      autoload :ItemCategoryImage,  'enjoy/catalog/admin/item_category_image'
    end

    module Models
      autoload :Item,               'enjoy/catalog/models/item'
      autoload :ItemCategory,       'enjoy/catalog/models/item_category'
      autoload :ItemImage,          'enjoy/catalog/models/item_image'
      autoload :ItemCategoryImage,  'enjoy/catalog/models/item_category_image'

      module Mongoid
        autoload :Item,               'enjoy/catalog/models/mongoid/item'
        autoload :ItemCategory,       'enjoy/catalog/models/mongoid/item_category'
        autoload :ItemImage,          'enjoy/catalog/models/mongoid/item_image'
        autoload :ItemCategoryImage,  'enjoy/catalog/models/mongoid/item_category_image'
      end
    end

    module Controllers
      autoload :Items,                'enjoy/catalog/controllers/items'
      autoload :ItemCategories,       'enjoy/catalog/controllers/item_categories'
    end
  end
end
