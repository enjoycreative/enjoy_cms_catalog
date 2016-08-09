module Enjoy::Catalog
  module Models
    module Mongoid
      module Item
        extend ActiveSupport::Concern

        include Enjoy::HtmlField

        included do
          field :name, type: String, localize: Enjoy::Catalog.configuration.localize, default: ""

          acts_as_nested_set
          scope :sorted, -> { order_by([:lft, :asc]) }

          enjoy_cms_html_field :excerpt,   type: String, localize: Enjoy::Catalog.configuration.localize, default: ""
          enjoy_cms_html_field :content,   type: String, localize: Enjoy::Catalog.configuration.localize, default: ""

          has_and_belongs_to_many :categories, class_name: "Enjoy::Catalog::Category", inverse_of: nil

          if Enjoy::Catalog.config.gallery_support
            embeds_many :item_images, cascade_callbacks: true, class_name: "Enjoy::Catalog::ItemImage"
            alias :images :item_images
            accepts_nested_attributes_for :item_images, allow_destroy: true
          end

          has_and_belongs_to_many :related_items, :class_name => "Enjoy::Catalog::Item", :inverse_of => :related_items

          # money_field :price, default_currency: nil
          field :price,     type: Money,    default: nil, localize: Enjoy::Catalog.configuration.localize
        end
      end
    end
  end
end
