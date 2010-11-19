require 'rubygems'
require 'opentox-ruby-api-wrapper'
require 'test/unit'
require 'validate-owl.rb'

class FminerTest < Test::Unit::TestCase

  def setup
    @dataset = OpenTox::Dataset.new "http://localhost/dataset/1"
    @feature = "http://localhost/dataset/1/feature/Hamster%20Carcinogenicity"
    @bbrc = OpenTox::Algorithm::Generic.new "http://localhost/algorithm/fminer/bbrc"
    @last = OpenTox::Algorithm::Generic.new "http://localhost/algorithm/fminer/last"
  end

  def teardown
  end

=begin
=end
  def test_bbrc
    dataset = OpenTox::Algorithm::Fminer::BBRC.new.run({:dataset_uri => @dataset.uri, :prediction_feature => @feature}).to_s
    #dataset = @bbrc.run({:dataset_uri => @dataset.uri, :prediction_feature => @feature}).to_s
    d =OpenTox::Dataset.new dataset
    d.load_features
    assert_equal 41, d.features.size
    #validate_owl
  end

  def test_last
    dataset = OpenTox::Algorithm::Fminer::LAST.new.run({:dataset_uri => @dataset.uri, :prediction_feature => @feature}).to_s
    d =OpenTox::Dataset.new dataset
    d.load_features
    assert_equal 36, d.features.size
    #validate_owl
  end

  def test_regression_bbrc
    @dataset = OpenTox::Dataset.new
    @dataset.save
    @dataset.load_csv(File.open("data/EPAFHM.csv").read)
    @dataset.save
    @feature = File.join @dataset.uri,"feature/LC50_mmol" 
    dataset = OpenTox::Algorithm::Fminer::BBRC.new.run({:dataset_uri => @dataset.uri, :prediction_feature => @feature}).to_s
    d =OpenTox::Dataset.new dataset
    d.load_features
    assert_equal 222, d.features.size
  end

  def test_regression_last
    @dataset = OpenTox::Dataset.new
    @dataset.save
    @dataset.load_csv(File.open("data/EPAFHM.csv").read)
    @dataset.save
    @feature = File.join @dataset.uri,"feature/LC50_mmol" 
    dataset = OpenTox::Algorithm::Fminer::LAST.new.run({:dataset_uri => @dataset.uri, :prediction_feature => @feature}).to_s
    d =OpenTox::Dataset.new dataset
    d.load_features
    assert_equal 16, d.features.size
  end
=begin
=end

end
