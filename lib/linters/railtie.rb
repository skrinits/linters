module Linters
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/linters.rake'
    end
  end
end
