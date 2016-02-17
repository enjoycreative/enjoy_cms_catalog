module Enjoy::Catalog
  class ItemsController < ApplicationController
    include Enjoy::Catalog::Controllers::Items

    include Enjoy::Catalog::Decorators::Items
  end
end
