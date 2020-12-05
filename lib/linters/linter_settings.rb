require 'yaml'
require 'json'

module Linters
  class LinterSettings
    DEFAULT_SETTINGS = {
      brakeman: {
        default_command: 'brakeman --quiet --skip-libs -f json',
        parse_output: ->(output) { JSON.parse(output)['scan_info']['security_warnings'] }
      },
      bundle_audit: {
        default_command: 'bundle-audit update > /dev/null 2>&1 && bundle-audit',
        parse_output: ->(output) { output.scan(/Name:/).count }
      },
      fasterer: {
        default_command: 'fasterer',
        parse_output: lambda { |output, lines_per_warning = 3|
          output.split("\n").length / lines_per_warning
        }
      },
      reek: {
        default_command: 'reek --format json *',
        parse_output: ->(output) { JSON.parse(output).size }
      },
      rubocop: {
        default_command: 'rubocop --format json',
        parse_output: ->(output) { JSON.parse(output)['summary']['offense_count'] }
      }
    }.freeze

    def initialize(name, custom_settings = {})
      @name = name
      @settings = DEFAULT_SETTINGS.fetch(name) { {} }
      @settings = @settings.merge(load_settings(name)).merge(custom_settings)
    end

    def name
      settings.fetch(:name) { @name }
    end

    def warnings_number
      settings.fetch(:warnings_number) { 0 }
    end

    def command
      settings.fetch(:command) { settings.fetch(:default_command) }
    end

    def parse_output
      settings[:parse_output]
    end

    private

    attr_reader :settings

    # :reek:UtilityFunction
    def load_settings(name)
      path = Linters.configuration.settings_path

      return {} unless File.exist?(path)

      (YAML.load_file(path)['linters'][name.to_s] || {}).each_with_object({}) do |item, result|
        result[item[0].to_sym] = item[1]
      end
    end
  end
end
