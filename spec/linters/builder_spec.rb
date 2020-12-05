require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

RSpec.describe Linters::Builder do
  describe '#perform' do
    let(:config) do
      instance_double(
        'Linters::Configuration',
        linters: linters,
        custom_linters: custom_linters,
        settings_path: 'settings_path'
      )
    end
    let(:linters) { %i[rubocop] }
    let(:custom_linters) do
      { custom_linter_name:
        { default_command: "echo 'test'",
          parse_output: ->(output) { puts(output) } } }
    end

    before do
      allow(Linters).to receive(:configuration).and_return(config)
    end

    it 'create to linters' do
      expect(subject.perform.size).to eq(2)
    end
  end
end
