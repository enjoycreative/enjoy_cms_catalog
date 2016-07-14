module Enjoy::Catalog
  module Models
    module Item
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
      # include Mongoid::MoneyField

      include Enjoy::Catalog.orm_specific('Item')

      include ManualSlug

      included do
        manual_slug :name

        if Enjoy::Catalog.config.pages_support and Enjoy::Catalog.configuration.can_connect_items_with_pages
          enjoy_connectable_field :connected_pages
        end

        if Enjoy::Catalog.config.gallery_support and Enjoy::Catalog.configuration.item_image_styles
          enjoy_cms_attached_file(:image,
                    styles: lambda { |attachment| attachment.instance.image_styles }
          )
        end
      end

      def image_styles
        Enjoy::Catalog.configuration.item_image_styles
      end

      def image_jcrop_options
        {}
      end
    end
  end
end
