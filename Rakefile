require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'tasks/opentox'

task :default => :features

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end
