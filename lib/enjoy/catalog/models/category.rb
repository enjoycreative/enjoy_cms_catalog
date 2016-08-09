module Enjoy::Catalog
  module Models
    module Category
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      if Enjoy::Catalog.config.seo_support
        include Enjoy::Seo::Seoable
        include Enjoy::Seo::SitemapDataField
      end
      if Enjoy::Catalog.config.pages_support
        include Enjoy::Pages::Connectable
      end
      if Enjoy::Catalog.config.gallery_support
        include Enjoy::Gallery::Paperclipable
      end

      include Enjoy::Catalog.orm_specific('Category')

      include ManualSlug

      included do
        manual_slug :name

        if Enjoy::Catalog.config.pages_support and Enjoy::Catalog.configuration.can_connect_category_with_pages
          enjoy_connectable_field :connected_pages
        end

        if Enjoy::Catalog.config.gallery_support and Enjoy::Catalog.configuration.category_image_styles
          enjoy_cms_attached_file(:image)
        end
      end

      def item_class
        Enjoy::Catalog::Item
      end

      def image_styles
        Enjoy::Catalog.configuration.category_image_styles
      end

    end
  end
end
