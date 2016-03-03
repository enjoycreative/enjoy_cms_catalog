require 'rails/generators'

module Enjoy::Catalog::Config
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Enjoy::Catalog Config generator'
    def install
      template 'enjoy_catalog.erb', "config/initializers/enjoy_catalog.rb"
    end

  end
end
