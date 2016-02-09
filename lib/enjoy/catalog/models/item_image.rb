module Enjoy::Catalog
  module Models
    module ItemImage
      extend ActiveSupport::Concern
      # include Enjoy::Model
      # include Enjoy::Enableable

      include Enjoy::Catalog.orm_specific('ItemImage')

      included do
      end

      module ClassMethods
        def rails_admin_add_fields
          {}
        end

        def rails_admin_add_config(config)
        end
      end
    end
  end
end
