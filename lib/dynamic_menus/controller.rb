module DynamicMenus

  module Controller
  
    def self.included(base)
      base.module_eval "before_filter :set_nodo"
    end

    def set_nodo

      session[:nodo_menu] = params[:nd] if params[:nd]

    end

  end

end