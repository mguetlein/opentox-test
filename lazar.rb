require 'rubygems'
require 'opentox-ruby-api-wrapper'
require 'test/unit'

class LazarTest < Test::Unit::TestCase

=begin
=end
  def test_create_regression_model
    model_uri = OpenTox::Algorithm::Lazar.new.run({:dataset_uri => @@regression_training_dataset.uri}).to_s
    lazar = OpenTox::Model::Lazar.find model_uri
    assert_equal lazar.features.size, 222
    compound = OpenTox::Compound.from_smiles("c1ccccc1NN")
    prediction_uri = lazar.run(:compound_uri => compound.uri)
    prediction = OpenTox::LazarPrediction.find(prediction_uri)
    assert_equal prediction.value(compound), 0.149518871336721
    assert_equal prediction.confidence(compound), 0.615246530364447
    assert_equal prediction.neighbors(compound).size, 81
    prediction.delete
    lazar.delete
  end

  def test_default_classification_model
    # create model
    model_uri = OpenTox::Algorithm::Lazar.new.run({:dataset_uri => @@classification_training_dataset.uri}).to_s
    lazar = OpenTox::Model::Lazar.find model_uri
    assert_equal lazar.features.size, 41
    # single prediction
    compound = OpenTox::Compound.from_smiles("c1ccccc1NN")
    prediction_uri = lazar.run(:compound_uri => compound.uri)
    prediction = OpenTox::LazarPrediction.find(prediction_uri)
    assert_equal prediction.value(compound), false
    assert_equal prediction.confidence(compound), 0.25857114104619
    assert_equal prediction.neighbors(compound).size, 15
    prediction.delete
    # dataset activity
    compound = OpenTox::Compound.from_smiles("CNN")
    prediction = OpenTox::LazarPrediction.find lazar.run(:compound_uri => compound.uri)
    assert !prediction.measured_activities(compound).empty?
    puts prediction.measured_activities(compound).first.inspect
    assert_equal prediction.measured_activities(compound).first, true
    assert prediction.value(compound).nil?
    prediction.delete
    # dataset prediction
    test_dataset = OpenTox::Dataset.create_from_csv_file("data/multicolumn.csv")
    prediction = OpenTox::LazarPrediction.find lazar.run(:dataset_uri => test_dataset.uri)
    assert_equal prediction.compounds.size, 4
    compound = OpenTox::Compound.new prediction.compounds.first
    assert_equal prediction.value(compound), false
    prediction.delete
    lazar.delete
  end

end
