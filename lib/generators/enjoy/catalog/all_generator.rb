require 'rails/generators'

module Enjoy::Catalog
  class AllGenerator < Rails::Generators::Base
    argument :class_name, type: :string

    desc 'Enjoy::Catalog generator'
    def all
      generate "enjoy:catalog:config:install"

      generate "enjoy:catalog:models:all #{class_name}"

      generate "enjoy:catalog:controllers:all #{class_name}"
    end

  end
end
