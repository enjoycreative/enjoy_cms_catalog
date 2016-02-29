module Enjoy::Catalog
  module Models
    module Mongoid
      module ItemCategory
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

          embeds_many :item_category_images, cascade_callbacks: true, class_name: "Enjoy::Catalog::ItemCategoryImage"
          alias :images :item_category_images
          accepts_nested_attributes_for :item_category_images, allow_destroy: true
        end

        def items
          item_class.in(item_category_ids: self.id)
        end

        def all_items
          item_class.any_in(item_category_ids: self.self_and_descendants.map(&:id))
        end

        def image_styles
          Enjoy::Catalog.configuration.item_category_image_styles
        end
      end
    end
  end
end
