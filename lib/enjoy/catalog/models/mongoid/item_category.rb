module Enjoy::Catalog
  module Models
    module Mongoid
      module ItemCategory
        extend ActiveSupport::Concern
        include Enjoy::MongoidPaperclip

        included do
          field :name, type: String, localize: Enjoy.configuration.localize, default: ""

          enjoy_cms_mongoid_attached_file(:image,
                    styles: lambda { |attachment| attachment.instance.image_styles },
                    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
          )

          acts_as_nested_set
          scope :sorted, -> { order_by([:lft, :asc]) }

          field :excerpt,   type: String, localize: Enjoy.configuration.localize, default: ""
          field :content,   type: String, localize: Enjoy.configuration.localize, default: ""

          embeds_many :item_category_images, cascade_callbacks: true, class_name: "Enjoy::Catalog::ItemCategoryImage"
          alias :images :item_category_images
          accepts_nested_attributes_for :item_category_images, allow_destroy: true
        end

        def image_styles
          Enjoy::Catalog.configuration.item_category_image_styles
        end
      end
    end
  end
end
