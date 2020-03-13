require 'spec_helper'

RSpec.describe RakeSSH do
  it 'has a version number' do
    expect(RakeSSH::VERSION).not_to be nil
  end

  context 'define_key_tasks' do
    context 'when instantiating RakeSSH::TaskSets::Key' do
      it 'passes the provided block' do
        opts = {
            path: '/some/key/path'
        }

        block = lambda do |t|
          t.type = 'DSA'
        end

        expect(RakeSSH::TaskSets::Key)
            .to(receive(:define) do |passed_opts, &passed_block|
              expect(passed_opts).to(eq(opts))
              expect(passed_block).to(eq(block))
            end)

        RakeSSH.define_key_tasks(opts, &block)
      end
    end
  end
end
