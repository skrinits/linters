require 'linters/version'
require 'linters/configuration'
require 'linters/linter_settings'
require 'linters/builder'
require 'linters/linter'
require 'linters/manager'
require 'linters/railtie' if defined?(Rails)

module Linters
  class << self
    def configuration
      @configuration ||= Linters::Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
