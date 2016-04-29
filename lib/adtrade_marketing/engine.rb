module AdtradeMarketing
  class Engine < ::Rails::Engine
    isolate_namespace AdtradeMarketing
    require 'github_parser'
    require 'github_worker'

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
    initializer :side do |app|
      Rails.application.config.eager_load = true
    end
  end
end
