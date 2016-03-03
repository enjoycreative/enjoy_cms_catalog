require 'rails/generators'

module Enjoy::Catalog::Models
  class ItemCategoryImageGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :class_name, type: :string
    argument :item_category_class_name_arg, type: :string, default: ""

    desc 'Enjoy::Catalog ItemCategoryImage Model generator'
    def item_category_image
      template 'item_category_image.erb', "app/models/#{file_name}.rb"
    end

    private
    def capitalized_class_name
      class_name.capitalize
    end

    def camelcased_class_name
      class_name.camelcase
    end

    def file_name
      underscored_class_name
    end

    def underscored_class_name
      camelcased_class_name.underscore
    end

    def underscored_pluralized_class_name
      underscored_class_name.pluralize
    end

    def item_category_class_name
      item_category_class_name_arg.blank? ? camelcased_class_name.sub(/Image$/, "") : item_category_class_name_arg
    end
  end
end
