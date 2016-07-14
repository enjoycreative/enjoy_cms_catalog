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
              field :slugs, :enum do
                enum_method do
                  :slugs
                end
                visible do
                  bindings[:view].current_user.admin?
                end
                multiple do
                  true
                end
              end
              field :text_slug
            end

            group :image do
              active false
              field :image, :jcrop do
                jcrop_options do
                  :image_jcrop_options
                end
              end

              field :item_images
            end

            group :content do
              active false
              field :excerpt, :enjoy_html
              field :content, :enjoy_html
            end

            Enjoy::RailsAdminGroupPatch::enjoy_cms_group(self, fields)

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
