# frozen_string_literal: true

require 'spec_helper'
require 'fileutils'

describe RakeSSH::TaskSets::Key do
  include_context 'rake'

  def define_tasks(opts = {}, &block)
    described_class.define({
      path: '/some/key/path'
    }.merge(opts), &block)
  end

  it 'adds all key tasks in the provided namespace when supplied' do
    define_tasks(namespace: :key)

    expect(Rake.application)
      .to(have_task_defined('key:generate'))
  end

  it 'adds all key tasks in the root namespace when none supplied' do
    define_tasks

    expect(Rake.application)
      .to(have_task_defined('generate'))
  end

  describe 'generate task' do
    it 'configures with the provided path' do
      path = '/key/goes/here'

      define_tasks(path: path)

      rake_task = Rake::Task['generate']

      expect(rake_task.creator.path).to(eq(path))
    end

    it 'uses a key prefix of ssh by default' do
      define_tasks

      rake_task = Rake::Task['generate']

      expect(rake_task.creator.name_prefix).to(eq('ssh'))
    end

    it 'uses the provided key prefix when specified' do
      name_prefix = 'key'

      define_tasks(
        name_prefix: name_prefix
      )

      rake_task = Rake::Task['generate']

      expect(rake_task.creator.name_prefix).to(eq(name_prefix))
    end

    it 'uses a type of RSA by default' do
      define_tasks

      rake_task = Rake::Task['generate']

      expect(rake_task.creator.type).to(eq('RSA'))
    end

    it 'uses the provided type when specified' do
      type = 'DSA'

      define_tasks(type: type)

      rake_task = Rake::Task['generate']

      expect(rake_task.creator.type).to(eq(type))
    end

    it 'uses 4096 bits by default' do
      define_tasks

      rake_task = Rake::Task['generate']

      expect(rake_task.creator.bits).to(eq(4096))
    end

    it 'uses the provided number of bits when specified' do
      bits = 2048

      define_tasks(bits: bits)

      rake_task = Rake::Task['generate']

      expect(rake_task.creator.bits).to(eq(bits))
    end

    it 'has no comment by default' do
      define_tasks

      rake_task = Rake::Task['generate']

      expect(rake_task.creator.comment).to(be_nil)
    end

    it 'uses the provided comment when specified' do
      comment = 'someone@example.com'

      define_tasks(comment: comment)

      rake_task = Rake::Task['generate']

      expect(rake_task.creator.comment).to(eq(comment))
    end

    it 'has no passphrase by default' do
      define_tasks

      rake_task = Rake::Task['generate']

      expect(rake_task.creator.passphrase).to(be_nil)
    end

    it 'uses the provided passphrase when specified' do
      passphrase = 'some-password'

      define_tasks(passphrase: passphrase)

      rake_task = Rake::Task['generate']

      expect(rake_task.creator.passphrase).to(eq(passphrase))
    end

    it 'uses a name of generate by default' do
      define_tasks

      expect(Rake::Task.task_defined?('generate')).to(be(true))
    end

    it 'uses the provided name when supplied' do
      define_tasks(generate_task_name: :regenerate)

      expect(Rake::Task.task_defined?('regenerate'))
        .to(be(true))
    end
  end
end
