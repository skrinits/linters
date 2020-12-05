module Linters
  class Linter
    def initialize(name, custom_settings = {})
      @settings = LinterSettings.new(name, custom_settings)
    end

    def perform
      command_output = `#{ settings.command }`

      settings.parse_output.call(command_output)
    end

    def method_missing(method, *args, &block)
      if %i[warnings_number name].include?(method)
        settings.send(method)
      else
        super
      end
    end

    # :reek:BooleanParameter
    def respond_to_missing?(method, include_private = false)
      %i[warnings_number name].include?(method) || super
    end

    private

    attr_reader :settings
  end
end
