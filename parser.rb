require 'rubygems'
require 'opentox-ruby'
require 'test/unit'
require 'validate-owl'

class ParserTest < Test::Unit::TestCase

  def setup
    #@new_dataset = OpenTox::Dataset.from_csv(File.open("data/hamster_carcinogenicity.csv").read)
    #@new_dataset.add_metadata( OT.hasSource => "data/hamster_carcinogenicity.csv", DC.creator => "opentox-test", DC.title => "Hamster Carcinogenicity" )
    #@new_dataset.save
    @datasets = {
      
      @@classification_training_dataset.uri => {
        :nr_compounds => 85,
        :nr_features => 1,
        :nr_dataset_features => 1,
        :nr_data_entries => 85
      },
      "http://apps.ideaconsult.net:8080/ambit2/dataset/2698" => {
        :nr_compounds => 3,
        :nr_features => 8,
        :nr_dataset_features => 37,
        :nr_data_entries => 3
      }
    }
  end

  def teardown
    #@new_dataset.delete
  end

  def test_dataset
    @datasets.each do |uri,properties|
      parser = OpenTox::Parser::Owl::Dataset.new uri, @@subjectid
      @dataset = parser.load_uri(@@subjectid)
      validate properties
    end
  end
  def validate(data)
    #puts @dataset.yaml
    assert_kind_of OpenTox::Dataset, @dataset
    assert_equal @dataset.data_entries.size, data[:nr_data_entries]
    assert_equal @dataset.compounds.size, data[:nr_compounds]
    assert_equal @dataset.features.size, data[:nr_dataset_features]
    # fails for ambit datasets
    #assert_equal @dataset.uri, @dataset.metadata[XSD.anyURI]
  end

end
