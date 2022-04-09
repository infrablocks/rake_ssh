# frozen_string_literal: true

require 'rake_ssh/version'
require 'rake_ssh/tasks'
require 'rake_ssh/task_sets'

module RakeSSH
  def self.define_key_tasks(opts = {}, &block)
    RakeSSH::TaskSets::Key.define(opts, &block)
  end
end
