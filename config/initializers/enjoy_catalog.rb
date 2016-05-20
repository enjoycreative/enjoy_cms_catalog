Enjoy.rails_admin_configure do |config|
  config.action_visible_for :nested_set, 'Enjoy::Catalog::Item'
  config.action_visible_for :nested_set, 'Enjoy::Catalog::Category'

  if Enjoy::Catalog.active_record?
    config.action_visible_for :nested_set, 'Enjoy::Catalog::ItemImage'
    config.action_visible_for :nested_set, 'Enjoy::Catalog::CategoryImage'
  elsif Enjoy::Catalog.mongoid?
    config.action_visible_for :sort_embedded, 'Enjoy::Catalog::Item'
    config.action_visible_for :sort_embedded, 'Enjoy::Catalog::Category'
  end

  if defined?(RailsAdminComments)
    config.action_visible_for :comments, 'Enjoy::Catalog::Item'
    config.action_visible_for :comments, 'Enjoy::Catalog::Category'
    config.action_visible_for :model_comments, 'Enjoy::Catalog::Item'
    config.action_visible_for :model_comments, 'Enjoy::Catalog::Category'
    if Enjoy::Catalog.active_record?
      config.action_visible_for :comments, 'Enjoy::Catalog::ItemImage'
      config.action_visible_for :comments, 'Enjoy::Catalog::CategoryImage'
      config.action_visible_for :model_comments, 'Enjoy::Catalog::ItemImage'
      config.action_visible_for :model_comments, 'Enjoy::Catalog::CategoryImage'
    end
  end

  if defined?(RailsAdminMultipleFileUpload)
    if Enjoy::Catalog.mongoid?
      config.action_visible_for :multiple_file_upload, 'Enjoy::Catalog::Item'
      config.action_visible_for :multiple_file_upload, 'Enjoy::Catalog::Category'
    end
  end
end

Enjoy.configure do |config|
  _actions = [:new, :create, :edit, :update, :nested_set, :multiple_file_upload, :sort_embedded]
  if Enjoy::Catalog.active_record?
    _actions.delete(:multiple_file_upload)
    _actions.delete(:sort_embedded)
  end

  config.ability_manager_config ||= []
  config.ability_manager_config << {
    method: :can,
    model: Enjoy::Catalog::Item,
    actions: _actions
  }
  config.ability_manager_config << {
    method: :can,
    model: Enjoy::Catalog::Category,
    actions: _actions
  }
  if Enjoy::Catalog.active_record?
    config.ability_manager_config << {
      method: :can,
      model: Enjoy::Catalog::ItemImage,
      actions: _actions
    }
    config.ability_manager_config << {
      method: :can,
      model: Enjoy::Catalog::CategoryImage,
      actions: _actions
    }
  end

  config.ability_admin_config ||= []
  config.ability_admin_config << {
    method: :can,
    model: Enjoy::Catalog::Item,
    actions: :manage
  }
  config.ability_admin_config << {
    method: :can,
    model: Enjoy::Catalog::Category,
    actions: :manage
  }
  if Enjoy::Catalog.active_record?
    config.ability_admin_config << {
      method: :can,
      model: Enjoy::Catalog::ItemImage,
      actions: :manage
    }
    config.ability_admin_config << {
      method: :can,
      model: Enjoy::Catalog::CategoryImage,
      actions: :manage
    }
  end
end

if defined?(RailsAdmin)
  RailsAdmin.config do |config|
    config.excluded_models ||= []
    if Enjoy::Catalog.mongoid?
      config.excluded_models << [
        'Enjoy::Catalog::ItemImage', 'Enjoy::Catalog::CategoryImage'
      ]
    end
    config.excluded_models.flatten!
  end
end
