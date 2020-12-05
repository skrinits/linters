require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

RSpec.describe Linters do
  it 'has a version number' do
    expect(Linters::VERSION).not_to be_nil
  end

  it '.configure' do
    Linters.configure do |config|
      config.linters = [:rubocop]
      config.custom_linters = {
        custom_linter_name: {
          default_command: 'command',
          parse_output: ->(output) { puts(output) }
        }
      }
    end

    config = Linters.configuration

    expect(config.linters).to eq([:rubocop])
    expect(config.custom_linters.keys).to eq([:custom_linter_name])
  end

  it '.configuration' do
    expect(Linters.configuration).not_to be_nil
  end
end
