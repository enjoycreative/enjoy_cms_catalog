module ActionDispatch::Routing
  class Mapper
    def enjoy_cms_catalog_routes(config = {})
      routes_config = {
        use_items_path: true,
        use_categories_path: true,
        use_catalog_path: true,
        catalog_path: 'catalog',
        classes: {
          items: :items,
          categories: :categories,
          catalog_controller: :categories
        },
        paths: {
          items: :items,
          categories: :categories
        }
      }
      routes_config.deep_merge!(config)

      generate_enjoy_catalog_user_routes(routes_config)
      generate_enjoy_catalog_cms_routes(routes_config)
    end


    private
    def generate_enjoy_catalog_user_routes(routes_config)
      if !routes_config[:use_items_path] and !routes_config[:classes][:items].nil?
        resources routes_config[:classes][:items].to_sym, only: [:show], path: routes_config[:paths][:items] do
          get '(/page/:page)', action: :index, on: :collection, as: ""
        end
      end

      if !routes_config[:use_categories_path] and !routes_config[:classes][:categories].nil?
        resources routes_config[:classes][:categories].to_sym, only: [:index, :show], path: routes_config[:paths][:categories] do
          get 'items(/page/:page)', action: :items, on: :member, as: :items
        end
      end

      if !routes_config[:use_catalog_path] and !routes_config[:classes][:catalog_controller].nil?
        get "#{routes_config[:catalog_path]}" => "#{routes_config[:classes][:catalog_controller]}#index"
      end
    end

    def generate_enjoy_catalog_cms_routes(routes_config)
      scope module: 'enjoy' do
        scope module: 'catalog' do
          if routes_config[:use_items_path] and !routes_config[:classes][:items].nil?
            resources routes_config[:classes][:items].to_sym, only: [:show], path: routes_config[:paths][:items], as: :enjoy_catalog_items do
              get '(/page/:page)', action: :index, on: :collection, as: ""
            end
          end

          if routes_config[:use_categories_path] and !routes_config[:classes][:categories].nil?
            resources routes_config[:classes][:categories].to_sym, only: [:index, :show], path: routes_config[:paths][:categories], as: :enjoy_catalog_categories do
              get 'items(/page/:page)', action: :items, on: :member, as: :items
            end
          end
          if routes_config[:use_catalog_path] and !routes_config[:classes][:catalog_controller].nil?
            get "#{routes_config[:catalog_path]}" => "#{routes_config[:classes][:catalog_controller]}#index", as: :enjoy_catalog
          end
        end
      end
    end

  end
end
