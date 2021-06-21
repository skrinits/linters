module Linters
  class Configuration
    # :reek:Attribute
    attr_accessor :custom_linters, :linters, :settings_path

    DEFAULT_CHECKERS = %i[rubocop reek bundle_audit fasterer].freeze

    def initialize
      @custom_linters = {}
      @settings_path = ENV.fetch('LINTERS_SETTING_PATH', 'config/linter_settings.yml')
      @linters = ENV.fetch('LINTERS_CHECKERS', load_checkers(@settings_path))
    end

    private

    def load_checkers(path)
      return DEFAULT_CHECKERS unless File.exist?(path)

      (YAML.load_file(path)['linters']['checkers'] || DEFAULT_CHECKERS).map(&:to_sym)
    end
  end
end
