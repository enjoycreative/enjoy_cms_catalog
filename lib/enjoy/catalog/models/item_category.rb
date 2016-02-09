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

      def items
        item_class.in(item_category_ids: self.id)
      end

      def all_items
        item_class.any_in(item_category_ids: self.self_and_descendants.map(&:id))
      end

      # module ClassMethods
      #   def rails_admin_add_fields
      #     {}
      #   end
      #
      #   def rails_admin_add_config(config)
      #   end
      # end

    end
  end
end
