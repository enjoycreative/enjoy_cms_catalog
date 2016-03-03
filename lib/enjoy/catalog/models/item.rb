module Enjoy::Catalog
  module Models
    module Item
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include Enjoy::Seoable
      include Enjoy::SitemapDataField

      include Enjoy::Catalog.orm_specific('Item')

      include ManualSlug

      included do
        manual_slug :name
      end
    end
  end
end
