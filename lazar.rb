require 'rubygems'
require 'opentox-ruby'
require 'test/unit'

class Float
  def round_to(x)
    (self * 10**x).round.to_f / 10**x
  end
end

class LazarTest < Test::Unit::TestCase

=begin
=end
  def test_create_regression_model
    model_uri = OpenTox::Algorithm::Lazar.new.run({:dataset_uri => @@regression_training_dataset.uri, :subjectid => @@subjectid}).to_s
    lazar = OpenTox::Model::Lazar.find model_uri, @@subjectid
    assert_equal lazar.features.size, 222
    compound = OpenTox::Compound.from_smiles("c1ccccc1NN")
    prediction_uri = lazar.run(:compound_uri => compound.uri, :subjectid => @@subjectid)
    prediction = OpenTox::LazarPrediction.find(prediction_uri, @@subjectid)
    assert_equal prediction.value(compound).round_to(4), 0.149518871336721.round_to(4)
    assert_equal prediction.confidence(compound).round_to(4), 0.615246530364447.round_to(4)
    assert_equal prediction.neighbors(compound).size, 81
    prediction.delete(@@subjectid)
    lazar.delete(@@subjectid)
  end

  def test_default_classification_model
    # create model
    model_uri = OpenTox::Algorithm::Lazar.new.run({:dataset_uri => @@classification_training_dataset.uri, :subjectid => @@subjectid}).to_s
    lazar = OpenTox::Model::Lazar.find model_uri, @@subjectid
    assert_equal lazar.features.size, 41

    # single prediction
    compound = OpenTox::Compound.from_smiles("c1ccccc1NN")
    #puts compound.uri
    prediction_uri = lazar.run(:compound_uri => compound.uri, :subjectid => @@subjectid)
    prediction = OpenTox::LazarPrediction.find(prediction_uri, @@subjectid)
    assert_equal prediction.value(compound), false
    assert_equal prediction.confidence(compound).round_to(4), 0.25857114104619.round_to(4)
    assert_equal prediction.neighbors(compound).size, 15
    prediction.delete(@@subjectid)
    # dataset activity
    compound = OpenTox::Compound.from_smiles("CNN")
    prediction_uri  = lazar.run(:compound_uri => compound.uri, :subjectid => @@subjectid)
    prediction = OpenTox::LazarPrediction.find prediction_uri, @@subjectid
    assert !prediction.measured_activities(compound).empty?
    #puts prediction.measured_activities(compound).first.inspect
    assert_equal prediction.measured_activities(compound).first, true
    assert prediction.value(compound).nil?
    prediction.delete(@@subjectid)
    # dataset prediction
    test_dataset = OpenTox::Dataset.create_from_csv_file("data/multicolumn.csv", @@subjectid)
    prediction = OpenTox::LazarPrediction.find lazar.run(:dataset_uri => test_dataset.uri, :subjectid => @@subjectid), @@subjectid
    assert_equal prediction.compounds.size, 4
    compound = OpenTox::Compound.new prediction.compounds.first
    #puts "compound"
    #puts compound.inspect
    #puts "prediction"
    #puts prediction.value(compound).inspect
    assert_equal prediction.value(compound), false
    prediction.delete(@@subjectid)
    lazar.delete(@@subjectid)
=begin
=end
  end

end
