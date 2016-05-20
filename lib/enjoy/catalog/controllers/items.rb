module Enjoy::Catalog
  module Controllers
    module Items
      extend ActiveSupport::Concern

      def index
        @item = item_class.enabled.sorted

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
      end

      private
      def category_class
        Enjoy::Catalog::Category
      end
      def item_class
        Enjoy::Catalog::Item
      end
      def page_title
        if @item.class.name == model.name
          @item.page_title
        else
          super
        end
      end
    end
  end
end
