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
            field :image
          end

          edit do
            field :enabled, :toggle
            field :name
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
            field :image, :jcrop do
              jcrop_options do
                :image_jcrop_options
              end
            end
            field :item_categories
            field :excerpt, :ck_editor
            field :content, :ck_editor

            field :item_images

            fields.each_pair do |name, type|
              if type.nil?
                field name
              else
                if type.is_a?(Array)
                  field name, type[0], &type[1]
                else
                  field name, type
                end
              end
            end

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
