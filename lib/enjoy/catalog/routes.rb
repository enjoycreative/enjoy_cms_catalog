module ActionDispatch::Routing
  class Mapper

    def enjoy_cms_catalog_routes(config = {})
      routes_config = {
        use_items_path: true,
        use_item_categories_path: true,
        use_catalog_path: true
      }
      routes_config.merge!(config)

      scope module: 'enjoy' do
        scope module: 'catalog' do
          if routes_config[:use_items_path]
            resources :items, only: [:show], as: :enjoy_catalog_items do
              get '(/page/:page)', action: :index, on: :collection, as: ""
            end
          end

          if routes_config[:use_item_categories_path]
            resources :item_categories, only: [:index, :show], as: :enjoy_catalog_item_categories do
              get 'items(/page/:page)', action: :items, on: :member, as: :items
            end
          end
          if routes_config[:use_catalog_path]
            get 'catalog' => 'item_categories#index', as: :enjoy_catalog
          end
        end
      end

    end

  end
end
