module Enjoy::Catalog
  module Admin
    module CategoryImage
      def self.config(nav_label = nil, fields = {})
        if Enjoy::Catalog.config.gallery_support
          if Enjoy::Catalog.mongoid?
            if block_given?
              Enjoy::Gallery::Admin::EmbeddedImage.config(fields) do |config|
                yield config
              end
            else
              Enjoy::Gallery::Admin::EmbeddedImage.config(fields)
            end

          else
            nav_label ||= I18n.t('enjoy.catalog')
            if block_given?
              Enjoy::Gallery::Admin::Image.config(nav_label, fields) do |config|
                yield config
              end
            else
              Enjoy::Gallery::Admin::Image.config(nav_label,fields)
            end
          end #if Enjoy::Catalog.mongoid?
        end #if Enjoy::Catalog.config.gallery_support

      end #def self.config(fields = {})

    end #module CategoryImage
  end #module Admin
end #module Enjoy::Catalog
