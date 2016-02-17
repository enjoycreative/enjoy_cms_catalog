module Enjoy::Catalog
  class ItemCategoriesController < ApplicationController
    include Enjoy::Catalog::Controllers::ItemCategories

    include Enjoy::Catalog::Decorators::ItemCategories
  end
end
