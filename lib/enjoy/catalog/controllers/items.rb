module Enjoy::Catalog
  module Controllers
    module Items
      extend ActiveSupport::Concern

      included do
        if Enjoy::Catalog.config.breadcrumbs_on_rails_support
          add_breadcrumb I18n.t('enjoy.breadcrumbs.items'), :enjoy_items_path, if: :insert_items_breadcrumbs
        end
      end

      def index
        @item = item_class.enabled.sorted
        insert_category_breadcrumbs if insert_breadcrumbs

        unless Enjoy::Catalog.config.items_per_page.nil?
          @item = @item.page(params[:page])
        end
      end

      def show
        @item = item_class.enabled.find(params[:id])

        if @item and @item.text_slug != params[:id]
          redirect_to @item, status_code: 301
          return true
        end

        if Enjoy::Catalog.config.breadcrumbs_on_rails_support
          insert_category_breadcrumbs if insert_breadcrumbs
          add_breadcrumb @item.name, url_for(@item), if: :insert_breadcrumbs
        end
      end

      private
      def category_class
        Enjoy::Catalog::Category
      end
      def item_class
        Enjoy::Catalog::Item
      end
      def page_title
        if @item
          @item.page_title
        else
          super
        end
      end

      def insert_breadcrumbs
        true
      end
      def insert_items_breadcrumbs
        true
      end
      def insert_category_breadcrumbs
      end

    end
  end
end
