require 'rails/generators'

module Enjoy::Catalog::Models
  class AllGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :class_name, type: :string
    argument :category_class_name_arg, type: :string, default: ""
    argument :image_class_name_arg, type: :string, default: ""
    argument :category_image_class_name_arg, type: :string, default: ""

    desc 'Enjoy::Catalog Models generator'
    def all
      generate "enjoy:catalog:models:item #{camelcased_class_name}"
      generate "enjoy:catalog:models:item_category #{category_class_name}"
      generate "enjoy:catalog:models:item_image #{image_class_name}"
      generate "enjoy:catalog:models:item_category_image #{category_image_class_name}"
    end

    private
    def capitalized_class_name
      class_name.capitalize
    end
    def camelcased_class_name
      class_name.camelcase
    end

    def category_class_name
      category_class_name_arg.blank? ? "#{camelcased_class_name}Category" : category_class_name_arg
    end
    def image_class_name
      image_class_name_arg.blank? ? "#{camelcased_class_name}Image" : image_class_name_arg
    end
    def category_image_class_name
      category_image_class_name_arg.blank? ? "#{camelcased_class_name}CategoryImage" : category_image_class_name_arg
    end

  end
end
