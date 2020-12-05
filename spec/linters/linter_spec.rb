require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

RSpec.describe Linters::Linter do
  subject(:linter) { described_class.new('name', custom_settings) }

  let(:settings) { instance_double('Linters::LinterSettings') }
  let(:custom_settings) { {} }

  before do
    allow(Linters::LinterSettings).to receive(:new).and_return(settings)
    allow(settings).to receive(:parse_output).and_return(->(output) { puts(output) })
    allow(settings).to receive(:command).and_return("echo 'test'")
  end

  it '#perform' do
    expect(settings).to receive(:parse_output)

    linter.perform
  end

  it '#warnings_number' do
    expect(settings).to receive(:warnings_number)

    linter.warnings_number
  end

  it '#name' do
    expect(settings).to receive(:name)

    linter.name
  end
end
