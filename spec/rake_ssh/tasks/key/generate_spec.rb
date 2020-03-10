require 'spec_helper'
require 'sshkey'

describe RakeSSH::Tasks::Key::Generate do
  include_context :rake

  before(:each) do
    stub_output
  end

  def define_task(opts = {}, &block)
    opts = {namespace: :key}.merge(opts)

    namespace opts[:namespace] do
      subject.define(opts, &block)
    end
  end

  it 'adds a generate task in the namespace in which it is created' do
    define_task(path: 'some/key/path')

    expect(Rake::Task.task_defined?('key:generate'))
        .to(be(true))
  end

  it 'gives the generate task a description' do
    define_task(path: 'some/key/path')

    expect(Rake::Task['key:generate'].full_comment)
        .to(eq('Generates an SSH key pair in some/key/path'))
  end

  it 'fails if no path is provided' do
    define_task

    expect {
      Rake::Task['key:generate'].invoke
    }.to raise_error(RakeFactory::RequiredParameterUnset)
  end

  it 'uses a default name prefix of ssh' do
    define_task

    rake_task = Rake::Task['key:generate']
    test_task = rake_task.creator

    expect(test_task.name_prefix).to(eq("ssh"))
  end

  it 'uses a default type of RSA' do
    define_task

    rake_task = Rake::Task['key:generate']
    test_task = rake_task.creator

    expect(test_task.type).to(eq("RSA"))
  end

  it 'uses a default number of bits of 4096' do
    define_task

    rake_task = Rake::Task['key:generate']
    test_task = rake_task.creator

    expect(test_task.bits).to(eq(4096))
  end

  it 'uses has no comment by default' do
    define_task

    rake_task = Rake::Task['key:generate']
    test_task = rake_task.creator

    expect(test_task.comment).to(be_nil)
  end

  it 'uses has no passphrase by default' do
    define_task

    rake_task = Rake::Task['key:generate']
    test_task = rake_task.creator

    expect(test_task.passphrase).to(be_nil)
  end

  it 'generates an SSH key and saves both public and private parts at the ' +
      'specified path' do
    path = '/some/local/path'
    name_prefix = 'key'
    type = 'DSA'
    bits = 1024
    comment = 'some-user@example.com'
    passphrase = 'passphrase'

    define_task(
        path: path,
        name_prefix: name_prefix,
        type: type,
        bits: bits,
        comment: comment,
        passphrase:passphrase)

    Rake::Task['key:generate'].invoke

    generated_private_key = File.read('/some/local/path/key.private')
    generated_public_key = File.read('/some/local/path/key.public')

    ssh_key = SSHKey.new(generated_private_key,
        passphrase: passphrase,
        comment: comment)

    expect(ssh_key.bits).to(eq(1024))
    expect(ssh_key.type).to(eq('dsa'))
    expect(generated_public_key).to(eq(ssh_key.ssh_public_key))
  end

  def stub_output
    [:print, :puts].each do |method|
      allow_any_instance_of(Kernel).to(receive(method))
      allow($stdout).to(receive(method))
      allow($stderr).to(receive(method))
    end
  end
end
