module Enjoy::Catalog
  module Admin
    module Item
      def self.config(fields = {})
        Proc.new {
          navigation_label I18n.t("enjoy.catalog")

          list do
            scopes [:sorted, :enabled, nil]

            field :enabled, :toggle do
              searchable false
            end
            field :name do
              searchable true
            end
            field :categories do
              searchable :name
            end
            if Enjoy::Catalog.config.pages_support and Enjoy::Catalog.configuration.can_connect_items_with_pages
              field :connected_pages, :enjoy_connectable
            end
          end

          edit do
            field :enabled, :toggle
            field :name
            if Enjoy::Catalog.config.pages_support and Enjoy::Catalog.configuration.can_connect_items_with_pages
              group :connected_pages do
                active false
                field :connected_pages, :enjoy_connectable do
                  read_only do
                    !bindings[:view].current_user.admin?
                  end
                end
              end
            end
            field :categories do
              searchable :name
            end
            field :price, :string
            # field :price, :money_field

            group :URL do
              active false
              field :slugs, :enjoy_slugs
              field :text_slug
            end

            if Enjoy::Catalog.config.gallery_support
              group :image do
                active false
                field :image, :enjoy_image
                field :item_images
              end
            end

            group :content do
              active false
              field :excerpt, :enjoy_html
              field :content, :enjoy_html
            end

            Enjoy::RailsAdminGroupPatch::enjoy_cms_group(self, fields)

            if Enjoy::Catalog.config.seo_support
              group :seo do
                active false
                field :seo do
                  active true
                end
              end
              group :sitemap_data do
                active false
                field :sitemap_data do
                  active true
                end
              end
            end
          end

          nested_set({max_depth: 1, scopes: []})

          sort_embedded(
              {
                  fields: [:item_images]
              }
          )

          if defined?(RailsAdminMultipleFileUpload)
            multiple_file_upload(
                {
                    fields: [:item_images]
                }
            )
          end

          if block_given?
            yield self
          end
        }
      end
    end
  end
end
