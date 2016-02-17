module Enjoy::Catalog
  module Controllers
    module Items
      extend ActiveSupport::Concern

      def index
        @z = item_class.enabled.sorted.to_a
        # index_crumbs
      end

      def show
        @item = item_class.enabled.find(params[:id])
        if !@item.text_slug.blank? and @item.text_slug != params[:id]
          redirect_to @item, status_code: 301
          return
        end
        @parent_seo_page = find_seo_page(item_categories_path) if @seo_page.blank?
        # item_crumbs
      end

      def page_title
        if @item
          @item.page_title
        else
          super
        end
      end

      private
      def item_category_class
        Enjoy::Catalog::ItemCategory
      end
      def item_class
        Enjoy::Catalog::Item
      end

      # def item_crumbs
      #   if @item
      #     if @item.item_categories.enabled.count == 1
      #       if @parent_seo_page
      #         _crumb = @parent_seo_page.name
      #         _crumb = @parent_seo_page.title if _crumb.blank?
      #         _crumb = @parent_seo_page.h1 if _crumb.blank?
      #         add_crumb _crumb, @parent_seo_page.fullpath
      #       end
      #
      #       @item_category = @item.item_categories.enabled.first
      #       _crumb = @item_category.name
      #       _crumb = @item_category.title if _crumb.blank?
      #       _crumb = @item_category.h1 if _crumb.blank?
      #       add_crumb _crumb, item_category_path(@item_category)
      #     end
      #     _crumb = @item.name
      #     _crumb = @item.title if _crumb.blank?
      #     _crumb = @item.h1 if _crumb.blank?
      #     add_crumb _crumb, item_path(@item)
      #   end
      # end
    end
  end
end
