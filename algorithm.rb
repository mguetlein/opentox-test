require 'rubygems'
require 'opentox-ruby-api-wrapper'
require 'test/unit'
require "./validate-owl.rb"

class AlgorithmTest < Test::Unit::TestCase

  def setup
    @algorithms = [
      "http://localhost/algorithm/fminer/bbrc",
      "http://localhost/algorithm/fminer/last",
      "http://localhost/algorithm/lazar",
      #"http://apps.ideaconsult.net:8080/ambit2/algorithm/J48",
    ]
  end

  def teardown
  end

=begin
  def test_metadata
    @algorithms.each do |algorithm|
      puts algorithm
      validate_owl(algorithm)
    end
  end
=end

  def test_run_external
    {
      #"http://opentox.informatik.tu-muenchen.de:8080/OpenTox-dev/algorithm/J48" => {:dataset_uri => "http://apps.ideaconsult.net:8080/ambit2/dataset/10", :prediction_feature => "http://apps.ideaconsult.net:8080/ambit2/feature/21595"},
      #"http://apps.ideaconsult.net:8080/ambit2/algorithm/toxtreeskinirritation" => {:dataset_uri => "http://apps.ideaconsult.net:8080/ambit2/dataset/2698" }, # TASK redirects to model
      "http://opentox.informatik.tu-muenchen.de:8080/OpenTox-dev/algorithm/CDKPhysChem" => {:dataset_uri => "http://apps.ideaconsult.net:8080/ambit2/dataset/2698" },
      #"http://apps.ideaconsult.net:8080/ambit2/algorithm/org.openscience.cdk.qsar.descriptors.molecular.ALOGPDescriptor" => {:dataset_uri => "http://apps.ideaconsult.net:8080/ambit2/dataset/2698" }
      #"http://opentox.ntua.gr:3000/algorithm/svm"
    }.each do |uri,params|
      algorithm = OpenTox::Algorithm::Generic.new uri
      dataset_uri = algorithm.run(params)
      dataset = OpenTox::Dataset.find dataset_uri
      puts dataset.to_yaml
    end
  end

end
