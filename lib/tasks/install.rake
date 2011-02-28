namespace :menus do

  desc "Copy Dynamic Menus css & images to public"
  task :install do
    require 'ftools'

    this_dir = File.dirname(__FILE__)
    root_dir = File.expand_path("#{this_dir}/../../")

    puts "-"*80

    dest = File.join(Rails.root, 'public', 'images', 'active.png')
    unless File.exist?(dest)
      File.copy File.join(root_dir, 'public', 'active.png'), dest
      puts "Copied #{dest}"
    end

    dest = File.join(Rails.root, 'public', 'stylesheets', 'menu.css')
    unless File.exist?(dest)
      File.copy File.join(root_dir, 'public', 'menu.css'), dest
      puts "Copied #{dest}"
    end

    dest = File.join(Rails.root, 'config', 'menus.yml')
    unless File.exist?(dest)
      File.copy File.join(root_dir, 'public', 'menus.yml'), dest
      puts "Copied #{dest}"
    end

    puts "-"*80

  end

end