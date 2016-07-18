module Enjoy::Catalog
  module Admin
    module Category
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
            if Enjoy::Catalog.config.pages_support and Enjoy::Catalog.configuration.can_connect_category_with_pages
              field :connected_pages, :enjoy_connectable
            end
          end

          edit do
            field :enabled, :toggle
            field :name
            if Enjoy::Catalog.config.pages_support and Enjoy::Catalog.configuration.can_connect_category_with_pages
              group :connected_pages do
                active false
                field :connected_pages, :enjoy_connectable do
                  read_only do
                    !bindings[:view].current_user.admin?
                  end
                end
              end
            end
            group :URL do
              active false
              field :slugs, :enjoy_slugs
              field :text_slug
            end


            group :image do
              active false
              field :image, :enjoy_image
              field :category_images
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

            group :items do
              active false
              field :items do
                read_only true
                help 'Список товаров'

                pretty_value do
                  bindings[:object].items.to_a.map { |i|
                    route = (bindings[:view] || bindings[:controller])
                    model_name = i.rails_admin_model
                    route.link_to(i.name, route.rails_admin.show_path(model_name: model_name, id: i.id), title: i.name)
                  }.join("<br>").html_safe
                end
              end
            end
          end

          show do
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
            field :enabled
            field :image
            field :excerpt
            field :content

            Enjoy::RailsAdminGroupPatch::enjoy_cms_group(self, fields)

            field :items do
              read_only true

              pretty_value do
                bindings[:object].items.to_a.map { |i|
                  route = (bindings[:view] || bindings[:controller])
                  model_name = i.rails_admin_model
                  route.link_to(i.name, route.rails_admin.show_path(model_name: model_name, id: i.id), title: i.name)
                }.join("<br>").html_safe
              end
            end
          end

          nested_set({max_depth: 2, scopes: []})

          sort_embedded(
              {
                  fields: [:category_images]
              }
          )

          if defined?(RailsAdminMultipleFileUpload)
            multiple_file_upload(
                {
                    fields: [:category_images]
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
