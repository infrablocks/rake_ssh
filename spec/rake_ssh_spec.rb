# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RakeSSH do
  it 'has a version number' do
    expect(RakeSSH::VERSION).not_to be_nil
  end

  describe 'define_key_tasks' do
    context 'when instantiating RakeSSH::TaskSets::Key' do
      # rubocop:disable RSpec/MultipleExpectations
      it 'passes the provided block' do
        opts = {
          path: '/some/key/path'
        }

        block = lambda do |t|
          t.type = 'DSA'
        end

        allow(RakeSSH::TaskSets::Key).to(receive(:define))

        described_class.define_key_tasks(opts, &block)

        expect(RakeSSH::TaskSets::Key)
          .to(have_received(:define) do |passed_opts, &passed_block|
            expect(passed_opts).to(eq(opts))
            expect(passed_block).to(eq(block))
          end)
      end
      # rubocop:enable RSpec/MultipleExpectations
    end
  end
end
