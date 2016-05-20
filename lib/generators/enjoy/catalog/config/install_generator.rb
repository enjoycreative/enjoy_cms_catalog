require 'rails/generators'

module Enjoy::Catalog
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Enjoy::Catalog Config generator'
    def config
      template 'enjoy_catalog.erb', "config/initializers/enjoy_catalog.rb"
    end

  end
end
