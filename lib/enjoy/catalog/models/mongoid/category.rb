module Enjoy::Catalog
  module Models
    module Mongoid
      module Category
        extend ActiveSupport::Concern
        include Enjoy::HtmlField

        included do
          field :name, type: String, localize: Enjoy::Catalog.configuration.localize, default: ""

          acts_as_nested_set
          scope :sorted, -> { order_by([:lft, :asc]) }

          enjoy_cms_html_field :excerpt,   type: String, localize: Enjoy::Catalog.configuration.localize, default: ""
          enjoy_cms_html_field :content,   type: String, localize: Enjoy::Catalog.configuration.localize, default: ""

          embeds_many :category_images, cascade_callbacks: true, class_name: "Enjoy::Catalog::CategoryImage"
          alias :images :category_images
          accepts_nested_attributes_for :category_images, allow_destroy: true
        end

        def items
          item_class.in(category_ids: self.id)
        end

        def all_items
          item_class.any_in(category_ids: self.self_and_descendants.map(&:id))
        end
      end
    end
  end
end
