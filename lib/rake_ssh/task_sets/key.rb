# frozen_string_literal: true

require 'rake_factory'

require_relative '../tasks'

module RakeSSH
  module TaskSets
    class Key < RakeFactory::TaskSet
      prepend RakeFactory::Namespaceable

      parameter :path, required: true
      parameter :name_prefix, default: 'ssh'
      parameter :type, default: 'RSA'
      parameter :bits, default: 4096
      parameter :comment
      parameter :passphrase

      parameter :argument_names

      parameter :generate_task_name, default: :generate

      task Tasks::Key::Generate,
           name: RakeFactory::DynamicValue.new { |ts|
             ts.generate_task_name
           }
    end
  end
end
