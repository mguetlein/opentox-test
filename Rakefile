require 'rubygems'
require 'opentox-ruby'

if File.exists? "auth.rb"
  require "auth"
else
  #exit "Please create an authenticatio
    TEST_USER = "guest"
    TEST_PW   = "guest"
end

task ARGV[0] do
  puts "Environment: #{ENV["RACK_ENV"]}"
  puts "Test: "+ARGV[0]+".rb"
  require "./"+ARGV[0]+".rb"
end

task :setup do
  @@subjectid = OpenTox::Authorization.authenticate(TEST_USER,TEST_PW) 
  @@classification_training_dataset = OpenTox::Dataset.create_from_csv_file("data/hamster_carcinogenicity.csv", @@subjectid)
  @@regression_training_dataset = OpenTox::Dataset.create_from_csv_file("data/EPAFHM.csv", @@subjectid)
end

task :teardown do
  @@classification_training_dataset.delete(@@subjectid)
  @@regression_training_dataset.delete(@@subjectid)
  OpenTox::Authorization.logout(@@subjectid)
end

[:all, :feature, :dataset, :fminer, :lazar, :authorization].each do |t|
  task :teardown => t
  task t => :setup 
end
