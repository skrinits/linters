module Linters
  class Manager
    def initialize
      @linters = Builder.new.perform
    end

    def perform_all
      linters.each do |linter|
        linter_name = linter.name

        warnings = linter.perform

        handle_warnings(linter_name, warnings, linter.warnings_number)
      end
    end

    def perform_by_name(name)
      linter = linters.select { |item| item.name == name }[0]

      warnings = linter.perform

      handle_warnings(linter.name, warnings, linter.warnings_number)
    end

    private

    attr_reader :linters

    def handle_warnings(linter_name, warnings, max_warnings)
      result = warnings <= max_warnings

      message = if result
        "#{ linter_name }: quantity of warnings - #{ warnings }/#{ max_warnings }"
      else
        "#{ linter_name }: quantity of warnings shouldn't be more "\
        "#{ max_warnings } (now #{ warnings })"
      end

      puts message

      exit(1) unless result
    end
  end
end
