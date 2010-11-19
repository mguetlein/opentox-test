require 'rubygems'
require 'opentox-ruby-api-wrapper'
require 'test/unit'

class LazarTest < Test::Unit::TestCase

  def setup
    @dataset = OpenTox::Dataset.new "http://localhost/dataset/1"
  end

  def teardown
  end

=begin
=end
  def test_create_regression_model
    @dataset = OpenTox::Dataset.create
    @dataset.load_csv(File.open("data/EPAFHM.csv").read)
    @dataset.save
    @feature = File.join @dataset.uri,"feature/LC50_mmol" 
    @model_uri = OpenTox::Algorithm::Lazar.new.run({:dataset_uri => @dataset.uri}).to_s
    model = OpenTox::Model::Lazar.find @model_uri
    puts model.to_yaml
  end

  def test_regr_prediction
    lazar = OpenTox::Model::Lazar.find("http://localhost/model/8")
    compound = OpenTox::Compound.from_smiles("c1ccccc1NN")
    prediction = lazar.run(:compound_uri => compound.uri)
    puts prediction
  end

  def test_default_classification_model
    @dataset_uri = "http://localhost/dataset/1"
    feature = "http://localhost/dataset/1/feature/Hamster%20Carcinogenicity"
    lazar = OpenTox::Algorithm::Lazar.new
    @model_uri = lazar.run({:dataset_uri => @dataset.uri, :prediction_feature => feature, :feature_generation_uri => File.join(CONFIG[:services]["opentox-algorithm"], "fminer","bbrc")}).to_s
    model = YAML.load(OpenTox::RestClientWrapper.get(@model_uri,:accept => "application/x-yaml"))
    assert_equal 41, model.features.size
    puts model.to_yaml
  end

  def test_classification_prediction
    lazar = OpenTox::Model::Lazar.find("http://localhost/model/7")
    compound = OpenTox::Compound.from_smiles("c1ccccc1NN")
    prediction = lazar.run(:compound_uri => compound.uri)
    puts prediction
  end

=begin
  def test_prediction_with_database_activity
    lazar = OpenTox::Model::Lazar.find("http://localhost/model/7")
    compound = OpenTox::Compound.from_smiles("CNN")
    prediction = lazar.run(:compound_uri => compound.uri)
    puts prediction
  end

  def test_dataset_prediction
    uri = RestClient.post('http://localhost/dataset', {:file => File.new("data/multicolumn.csv")},{:accept => "text/uri-list"}).to_s.chomp
    lazar = OpenTox::Model::Lazar.find("http://localhost/model/7")
    #prediction = lazar.run(:dataset_uri => uri)
    prediction = lazar.predict_dataset(uri)
    puts prediction.to_yaml
  end

  def test_create_dataset_model
  end

  def test_classification_prediction
    @model_uri = OpenTox::Model::Lazar.all.last
    model = OpenTox::Model::Lazar.new(@model_uri)
    compound = OpenTox::Compound.from_smiles("c1ccccc1NN")
    puts model.run(:compound_uri => compound.uri)
  end
=end

  def test_regression_prediction
  end
end
