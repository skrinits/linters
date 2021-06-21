module Linters
  class Configuration
    # :reek:Attribute
    attr_accessor :custom_linters, :linters, :settings_path

    def initialize
      @custom_linters = {}
      @linters = ENV.fetch('LINTERS_CHECKERS', %i[rubocop reek bundle_audit fasterer])
      @settings_path = ENV.fetch('LINTERS_SETTING_PATH', 'config/settings.yml')
    end
  end
end
