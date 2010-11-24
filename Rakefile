require 'rubygems'
require 'opentox-ruby'

task ARGV[0] do
  puts ARGV[0]+".rb"
  require "./"+ARGV[0]+".rb"
end

task :setup do
  @@classification_training_dataset = OpenTox::Dataset.create_from_csv_file("data/hamster_carcinogenicity.csv")
  @@regression_training_dataset = OpenTox::Dataset.create_from_csv_file("data/EPAFHM.csv")
end

task :teardown do
  @@classification_training_dataset.delete
  @@regression_training_dataset.delete
end

[:all, :feature, :dataset, :fminer, :lazar].each do |t|
  task :teardown => t
  task t => :setup 
end
