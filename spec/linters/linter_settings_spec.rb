require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

RSpec.describe Linters::LinterSettings do
  subject(:linter_settings) { described_class.new(linter_name) }

  let(:linter_name) { :rubocop }

  describe '#load_settings' do
    subject { linter_settings.send(:load_settings, linter_name) }

    context "if setting's file exists" do
      it { is_expected.to eq(warnings_number: 0) }
    end

    context "if setting's file doesn't exist" do
      before { allow(File).to receive(:exist?).and_return(false) }

      it { is_expected.to be_empty }
    end
  end
end
