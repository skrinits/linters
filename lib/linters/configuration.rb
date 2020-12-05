module Linters
  class Configuration
    # :reek:Attribute
    attr_accessor :custom_linters, :linters, :settings_path

    def initialize
      @custom_linters = {}
      @linters = %i[rubocop reek bundle_audit fasterer]
      @settings_path = 'config/settings.yml'
    end
  end
end
