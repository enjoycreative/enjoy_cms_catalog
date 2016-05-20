require 'rails/generators'

module Enjoy::Catalog::Models
  class CategoryImageGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :class_name, type: :string
    argument :category_class_name_arg, type: :string, default: ""

    desc 'Enjoy::Catalog CategoryImage Model generator'
    def category_image
      template 'category_image.erb', "app/models/#{file_name}.rb"
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

    def camelcased_category_class_name
      category_class_name.camelcase
    end

    def category_class_name
      category_class_name_arg.blank? ? camelcased_class_name.sub(/Image$/i, "") : category_class_name_arg
    end
  end
end
