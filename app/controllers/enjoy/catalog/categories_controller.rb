module Enjoy::Catalog
  class CategoriesController < ApplicationController
    include Enjoy::Catalog::Controllers::Categories

    include Enjoy::Catalog::Decorators::Categories
  end
end
