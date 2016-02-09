module Enjoy::Catalog
  module Admin
    module ItemCategory
      def self.config(fields = {})
        Proc.new {

          list do
            scopes [:sorted, :enabled, nil]

            field :enabled, :toggle
            field :name
            field :image

            field :items do
              read_only true

              pretty_value do
                bindings[:object].items.to_a.map { |h|
                  (bindings[:view] || bindings[:controller]).link_to(h.name, (bindings[:view] || bindings[:controller]).rails_admin.show_path(model_name: "item", id: h.id), title: h.name)
                }.join("<br>").html_safe
              end
            end
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
            field :excerpt, :ck_editor
            field :content, :ck_editor

            field :item_category_images

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

            field :items do
              read_only true
              help 'Список товаров'

              pretty_value do
                bindings[:object].items.to_a.map { |h|
                  (bindings[:view] || bindings[:controller]).link_to(h.name, (bindings[:view] || bindings[:controller]).rails_admin.edit_path(model_name: "item", id: h.id), title: h.name)
                }.join("<br>").html_safe
              end
            end
          end

          show do
            field :name
            field :sidebar_title
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
            field :enabled
            field :image
            field :excerpt
            field :content

            field :items do
              read_only true

              pretty_value do
                bindings[:object].items.to_a.map { |h|
                  (bindings[:view] || bindings[:controller]).link_to(h.name, (bindings[:view] || bindings[:controller]).rails_admin.show_path(model_name: "item", id: h.id), title: h.name)
                }.join("<br>").html_safe
              end
            end
          end

          nested_set({max_depth: 2, scopes: []})

          sort_embedded(
              {
                  fields: [:item_category_images]
              }
          )

          if defined?(RailsAdminMultipleFileUpload)
            multiple_file_upload(
                {
                    fields: [:item_category_images]
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
