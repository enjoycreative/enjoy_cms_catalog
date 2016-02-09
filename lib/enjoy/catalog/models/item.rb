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

        rails_admin(&Enjoy::Catalog::Admin::Item.config(rails_admin_add_fields) { |config|
          rails_admin_add_config(config)
        })
      end

      def clean_excerpt
        Rails::Html::FullSanitizer.new.sanitize(self.excerpt.strip)
      end

      def clean_content
        Rails::Html::FullSanitizer.new.sanitize(self.content.strip)
      end

      module ClassMethods
        def rails_admin_add_fields
          {}
        end

        def rails_admin_add_config(config)
        end
      end
    end
  end
end
