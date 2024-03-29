# frozen_string_literal: true

require 'rake_factory'
require 'sshkey'

module RakeSSH
  module Tasks
    module Key
      class Generate < RakeFactory::Task
        default_name :generate
        default_description(RakeFactory::DynamicValue.new do |t|
          "Generates an SSH key pair in #{t.path}"
        end)

        parameter :path, required: true
        parameter :name_prefix, default: 'ssh'
        parameter :type, default: 'RSA'
        parameter :bits, default: 4096
        parameter :comment
        parameter :passphrase

        action do |t|
          $stdout.print(
            "Generating SSH key '#{t.name_prefix}' in '#{t.path}'..."
          )
          key = SSHKey.generate(
            type: t.type,
            bits: t.bits,
            comment: t.comment,
            passphrase: t.passphrase
          )
          verbose(false) do
            mkdir_p(t.path)
          end
          File.open("#{t.path}/#{t.name_prefix}.private", 'w') do |f|
            f.write(key.private_key)
          end
          File.open("#{t.path}/#{t.name_prefix}.public", 'w') do |f|
            f.write(key.ssh_public_key)
          end
          puts 'Done.'

          $stdout.puts 'Done.'
        end
      end
    end
  end
end
