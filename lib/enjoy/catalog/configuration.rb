module Enjoy::Catalog
  def self.configuration
    @configuration ||= Configuration.new
  end
  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :item_image_styles
    attr_accessor :item_per_page

    attr_accessor :item_images_image_styles

    attr_accessor :category_image_styles
    attr_accessor :category_per_page

    attr_accessor :category_images_image_styles

    attr_accessor :gallery_support
    attr_accessor :seo_support
    attr_accessor :pages_support

    attr_accessor :can_connect_items_with_pages
    attr_accessor :can_connect_category_with_pages

    attr_accessor :localize

    def initialize
      @item_image_styles  = {}
      @item_per_page      = 10

      @item_images_image_styles = {}

      @category_image_styles = {}
      @category_per_page     = 10

      @category_images_image_styles = {}

      @gallery_support = defined?(Enjoy::Gallery)
      @seo_support = defined?(Enjoy::Seo)
      @pages_support = defined?(Enjoy::Pages)

      @can_connect_items_with_pages = true
      @can_connect_category_with_pages = true

      @localize = Enjoy.config.localize
    end
  end
end
