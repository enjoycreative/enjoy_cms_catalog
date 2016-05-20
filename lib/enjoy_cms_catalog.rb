unless defined?(Enjoy) && Enjoy.respond_to?(:orm) && [:active_record, :mongoid].include?(Enjoy.orm)
  puts "please use enjoy_cms_mongoid or enjoy_cms_activerecord"
  puts "also: please use enjoy_cms_mongoid or enjoy_cms_activerecord and not enjoy_cms directly"
  exit 1
end

require "enjoy/catalog/version"
require 'enjoy/catalog/engine'
require 'enjoy/catalog/configuration'

require 'enjoy/catalog/routes'

require 'money-rails'
# require 'mongoid_money_field'

module Enjoy::Catalog
  class << self
    def orm
      Enjoy.orm
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
    autoload :Item,           'enjoy/catalog/admin/item'
    autoload :Category,       'enjoy/catalog/admin/category'
    autoload :ItemImage,      'enjoy/catalog/admin/item_image'
    autoload :CategoryImage,  'enjoy/catalog/admin/category_image'
  end

  module Models
    autoload :Item,           'enjoy/catalog/models/item'
    autoload :Category,       'enjoy/catalog/models/category'
    autoload :ItemImage,      'enjoy/catalog/models/item_image'
    autoload :CategoryImage,  'enjoy/catalog/models/category_image'

    module Mongoid
      autoload :Item,           'enjoy/catalog/models/mongoid/item'
      autoload :Category,       'enjoy/catalog/models/mongoid/category'
      autoload :ItemImage,      'enjoy/catalog/models/mongoid/item_image'
      autoload :CategoryImage,  'enjoy/catalog/models/mongoid/category_image'
    end

    # module ActiveRecord
    #   autoload :Item,           'enjoy/catalog/models/active_record/item'
    #   autoload :Category,       'enjoy/catalog/models/active_record/category'
    #   autoload :ItemImage,      'enjoy/catalog/models/active_record/item_image'
    #   autoload :CategoryImage,  'enjoy/catalog/models/active_record/category_image'
    # end
  end

  module Controllers
    autoload :Items,            'enjoy/catalog/controllers/items'
    autoload :Categories,       'enjoy/catalog/controllers/categories'
  end

end
