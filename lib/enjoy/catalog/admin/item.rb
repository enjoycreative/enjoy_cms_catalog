module Enjoy::Catalog
  module Admin
    module Item
      def self.config(fields = {})
        Proc.new {
          list do
            scopes [:sorted, :enabled, nil]

            field :enabled, :toggle
            field :name
            field :price
            field :item_categories
            field :connected_pages, :enjoy_connectable
            field :image
          end

          edit do
            field :enabled, :toggle
            field :name
            field :connected_pages, :enjoy_connectable
            field :item_categories

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
            end

            group :content do
              active false
              field :excerpt, :enjoy_html
              field :content, :enjoy_html
            end

            field :item_images

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
