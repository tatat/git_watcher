ENV['ROOT'] ||= File.expand_path File.dirname(__FILE__)
ENV['LIB']  ||= File.join ENV['ROOT'], 'lib'

$:.unshift ENV['ROOT'] unless $:.include? ENV['ROOT']
$:.unshift ENV['LIB'] unless $:.include? ENV['LIB']

require 'lib/settings'
require 'lib/guard/git_watcher'

guard :git_watcher, branch: Settings.branch do
  watch(%r{^(?<!\.git/).+})
end