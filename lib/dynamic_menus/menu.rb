require 'yaml'
require 'tree'

module DynamicMenus

  class Menu < ::Tree::TreeNode

    def self.load(yaml)
      @@counter = 0
      menus = YAML.load_file(yaml)
      @root = Menu.new("ROOT", "")
      @root.add_menus(menus)
      @root
    end

    def get(id)
      self.find {|node| node.name == id}
    end
 
    def add_menus(menus)
      ret = []
      menus.each do |nodo|
        subs = nodo.delete('subs')
        new_menu = Menu.new(@@counter += 1, nodo)
        self << new_menu
        new_menu.add_menus(subs) if subs
      end
    end

    def method_missing(meth, *args, &blk)
      self.content[meth.to_s] || super
    end

    def has_link?
      self.link && self.link != '' rescue false
    end
    
    def aba?
      self.level == 1
    end

  end

end

