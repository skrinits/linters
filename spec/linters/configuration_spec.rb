require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

RSpec.describe Linters::Configuration do
  it '#new' do
    expect(subject.custom_linters).to eq({})
    expect(subject.linters).to eq(%i[rubocop reek bundle_audit fasterer])
    expect(subject.settings_path).to eq('config/linter_settings.yml')
  end
end
