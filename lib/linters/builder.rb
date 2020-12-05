require 'json'

module Linters
  class Builder
    def initialize
      @config = Linters.configuration
    end

    def perform
      result = config.linters.map { |linter| Linter.new(linter) }

      result + config.custom_linters.map { |linter, settings| Linter.new(linter, settings) }
    end

    private

    attr_reader :config
  end
end
