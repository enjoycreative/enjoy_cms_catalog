module Enjoy::Catalog
  module Models
    module ItemCategory
      extend ActiveSupport::Concern
      include Enjoy::Model
      include Enjoy::Enableable
      include Enjoy::Seoable
      include Enjoy::SitemapDataField

      include Enjoy::Catalog.orm_specific('ItemCategory')

      include ManualSlug

      included do
        manual_slug :name
      end

      def clean_excerpt
        Rails::Html::FullSanitizer.new.sanitize(self.excerpt.strip)
      end

      def clean_content
        Rails::Html::FullSanitizer.new.sanitize(self.content.strip)
      end

      def item_class
        Enjoy::Catalog::Item
      end

    end
  end
end
