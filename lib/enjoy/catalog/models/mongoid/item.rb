module Enjoy::Catalog
  module Models
    module Mongoid
      module Item
        extend ActiveSupport::Concern
        include Enjoy::MongoidPaperclip

        include Enjoy::HtmlField

        included do
          if defined?(RailsAdminComments)
            include RailsAdminComments::Commentable
          end
          
          field :name, type: String, localize: Enjoy.configuration.localize, default: ""

          enjoy_cms_mongoid_attached_file(:image,
                    styles: lambda { |attachment| attachment.instance.image_styles },
                    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
          )

          acts_as_nested_set
          scope :sorted, -> { order_by([:lft, :asc]) }

          enjoy_cms_html_field :excerpt,   type: String, localize: Enjoy.configuration.localize, default: ""
          enjoy_cms_html_field :content,   type: String, localize: Enjoy.configuration.localize, default: ""

          has_and_belongs_to_many :item_categories, class_name: "Enjoy::Catalog::ItemCategory", inverse_of: nil
          alias :categories :item_categories

          embeds_many :item_images, cascade_callbacks: true, class_name: "Enjoy::Catalog::ItemImage"
          alias :images :item_images
          accepts_nested_attributes_for :item_images, allow_destroy: true

          has_and_belongs_to_many :related_items, :class_name => "Enjoy::Catalog::Item", :inverse_of => :related_items

          field :price,     type: Money,    default: nil, localize: Enjoy.configuration.localize
        end

        def image_styles
          Enjoy::Catalog.configuration.item_image_styles
        end
      end
    end
  end
end
