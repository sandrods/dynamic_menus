module DynamicMenus
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      ActionView::Base.send(:include, DynamicMenus::Helper)
      ActionController::Base.send(:include, DynamicMenus::Controller)
      DynamicMenus::MENU = DynamicMenus::Menu.load(::Rails.root.join("config/menus.yml"))
    end
    rake_tasks do
      load "tasks/install.rake"
    end
  end
end