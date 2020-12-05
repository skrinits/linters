require_relative '../linters'

namespace :linters do
  desc 'Run linters or the linter with the specific name'
  task :run, [:name] => :environment do |_, args|
    raise "Please, set the linter's name" if args.name.nil?

    manager = Linters::Manager.new

    manager.perform_by_name(args.name.to_sym)
  end

  desc 'Run all linters'
  task run_all: :environment do
    manager = Linters::Manager.new

    manager.perform_all
  end
end
