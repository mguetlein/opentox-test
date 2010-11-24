require 'rubygems'
require 'opentox-ruby'
require 'test/unit'
require 'validate-owl.rb'

class FminerTest < Test::Unit::TestCase

=begin
=end
  def test_bbrc
    feature = @@classification_training_dataset.features.keys.first
    dataset_uri = OpenTox::Algorithm::Fminer::BBRC.new.run({:dataset_uri => @@classification_training_dataset.uri, :prediction_feature => feature}).to_s
    d =OpenTox::Dataset.new dataset_uri
    d.load_features
    assert_equal 41, d.features.size
    #validate_owl
    d.delete
  end

  def test_last
    feature = @@classification_training_dataset.features.keys.first
    dataset_uri = OpenTox::Algorithm::Fminer::LAST.new.run({:dataset_uri => @@classification_training_dataset.uri, :prediction_feature => feature}).to_s
    d =OpenTox::Dataset.new dataset_uri
    d.load_features
    assert_equal 36, d.features.size
    #validate_owl
    d.delete
  end

  def test_regression_bbrc
    feature = File.join @@regression_training_dataset.uri,"feature/LC50_mmol" 
    dataset_uri = OpenTox::Algorithm::Fminer::BBRC.new.run({:dataset_uri => @@regression_training_dataset.uri, :prediction_feature => feature}).to_s
    d =OpenTox::Dataset.new dataset_uri
    d.load_features
    assert_equal 222, d.features.size
    d.delete
  end

  def test_regression_last
    feature = File.join @@regression_training_dataset.uri,"feature/LC50_mmol" 
    dataset_uri = OpenTox::Algorithm::Fminer::LAST.new.run({:dataset_uri => @@regression_training_dataset.uri, :prediction_feature => feature}).to_s
    d =OpenTox::Dataset.new dataset_uri
    d.load_features
    assert_equal 16, d.features.size
    d.delete
  end
=begin
=end

end
