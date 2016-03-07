module Enjoy::Catalog
  module Models
    module ItemCategory
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include Enjoy::Seoable
      include Enjoy::SitemapDataField
      include Enjoy::Connectable

      include Enjoy::Catalog.orm_specific('ItemCategory')

      include ManualSlug

      included do
        manual_slug :name

        enjoy_connectable_field :connected_pages
      end

      def item_class
        Enjoy::Catalog::Item
      end

    end
  end
end
