require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

RSpec.describe Linters::Manager do
  let(:builder) { instance_double('Linters::Builder') }
  let(:linter) { Linters::Linter.new('test') }

  before do
    allow(Linters::Builder).to receive(:new).and_return(builder)
    allow(builder).to receive(:perform).and_return([linter])

    allow(linter).to receive(:perform).and_return(1)
  end

  describe '#perform_all' do
    it do
      expect(subject).to receive(:handle_warnings).with('test', 1, 0)

      subject.perform_all
    end
  end

  describe '#perform_by_name' do
    it do
      expect(subject).to receive(:handle_warnings).with('test', 1, 0)

      subject.perform_by_name('test')
    end
  end

  describe '#handle_warnings' do
    context 'if warnings is less or equal than max warnings' do
      let(:expected_message) { 'test: quantity of warnings - 0/1' }

      it 'send the message to STDOUT' do
        expect(STDOUT).to receive(:puts).with(expected_message)

        subject.send(:handle_warnings, 'test', 0, 1)
      end

      it 'exit with 0 status' do
        expect(Object).not_to receive(:exit).with(1)

        subject.send(:handle_warnings, 'test', 0, 1)
      end
    end

    context 'if warnings is more than max warnings' do
      let(:expected_message) do
        "test: quantity of warnings shouldn't be more 0 (now 1)"
      end

      it 'send the message to STDOUT' do
        expect(STDOUT).to receive(:puts).with(expected_message)

        subject.send(:handle_warnings, 'test', 1, 0)
      end

      it 'exit with 0 status' do
        expect { subject.send(:handle_warnings, 'test', 1, 0) }.to exit_with_code(1)
      end
    end
  end
end
