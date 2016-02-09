Enjoy::Catalog::Engine.routes.draw do
  routes_config = Enjoy::Catalog.configuration.routes_config

  if !routes_config or routes_config[:use_items_path]
    resources :items, only: [:show] do
      get '(/page/:page)', action: :index, on: :collection, as: ""
    end
  end

  if !routes_config or routes_config[:use_item_categories_path]
    resources :item_categories, only: [:index, :show] do
      get 'items(/page/:page)', action: :items, on: :member, as: :items
    end
  end
  if !routes_config or routes_config[:use_catalog_path]
    get 'catalog' => 'item_categories#index', as: :catalog
  end
end
