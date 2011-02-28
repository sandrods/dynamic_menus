module DynamicMenus
  module Helper
  
    def dynamic_menu
      if id = session[:nodo_menu]
        nodo = DynamicMenus::MENU.get(id.to_i)
      else
        nodo = DynamicMenus::MENU
      end
    
      conteudo = ''
      conteudo = yield if block_given?

      html = <<-HTML
        <div id="menu">
      		#{conteudo}		
      		<ul id="nav">#{abas(nodo)}</ul>
        </div>
        <div id='sub-menu'>#{sub_menu(nodo)}</div>
      HTML

      html.html_safe
    end

    def abas(menu)

      root = menu.root

      ret = ''
      root.children do |a|
        active = (!menu.is_root? && (a==menu || menu.parentage.include?(a))) ? "class='active'" : ''
        link = a.has_link? ? a.link : a.children.first.link
        lt = link_to(a.title, Rails.application.routes.url_helpers.send(link, :nd => a.name ))
        ret << "<li #{active}>#{lt}</li>\n"
      end
      ret
    end

    def sub_menu(menu, active=nil)     
      sm = sub_menu(menu.parent, menu) if menu && menu.parent && menu.parent.parent
      (sm||'') + escreve(menu, active)
    end

    def escreve(menu, active)
      return "<h3></h3>" unless menu
      if !menu.children || menu.children.empty? || menu.parent==nil
        if menu.aba? || menu.parent==nil
          return "<h3></h3>"
        else
          return ""
        end
      end
      active = menu.children.first unless active

      last = menu.children.last

      linha = menu.children.map do |n|

        if n.name == (active && active.name)
          if n.name == (last && last.name)
            opt = {:class => 'active last'}
          else
            opt = {:class => 'active'}
          end
        else
          opt = {:class => 'last'} if n.name == (last && last.name)
        end
        link = n.has_link? ? n.link : n.children.first.link
        link_to n.title, Rails.application.routes.url_helpers.send(link, :nd => n.name), opt
      end

      if menu.aba?
        "<h3>#{linha.compact.join}</h3>"
      else
        "<h2>#{linha.compact.join}</h2>"    
      end
    end

    def has_permission(nodo)
      true
      #nodo.permissoes.empty? || session[:ticket].permissao?('ADMIN') || nodo.permissoes.map{|i| i.id}.include?(session[:ticket].setor_id)
    end

  end
end