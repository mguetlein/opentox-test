require 'rubygems'
require 'opentox-ruby'
require 'test/unit'
require 'validate-owl'

class DatasetTest < Test::Unit::TestCase

  def setup
    @datasets = {
      @@regression_training_dataset.uri => nil,
      @@classification_training_dataset.uri => {
        :nr_compounds => 85,
        :nr_features => 1,
        :nr_dataset_features => 1,
        :nr_data_entries => 85
      },
      "http://apps.ideaconsult.net:8080/ambit2/dataset/2698" => {
        :nr_compounds => 3,
        :nr_features => 8,
        :nr_dataset_features => 36,
        :nr_data_entries => 3
      }
    }
  end

  def teardown
    #@new_dataset.delete
  end

=begin
  def test_save_external

    @dataset = OpenTox::Dataset.find "http://apps.ideaconsult.net:8080/ambit2/dataset/2698"
    #File.open("test.rdf","w+"){|f| f.puts @dataset.to_rdfxml}
    @dataset.uri = "http://apps.ideaconsult.net:8080/ambit2/dataset" 
    uri = @dataset.save(@@subjectid)
    puts uri
    #@dataset.load_csv(File.open("data/hamster_carcinogenicity.csv").read)
    #@dataset.save
  end
=end

  def test_create
    dataset = OpenTox::Dataset.create(CONFIG[:services]["opentox-dataset"], @@subjectid)
    dataset.save(@@subjectid)
    assert_kind_of URI::HTTP, URI.parse(dataset.uri)
    dataset.delete(@@subjectid)
  end

  def test_all
    datasets = OpenTox::Dataset.all
    assert_kind_of Array, datasets
  end

  def test_owl
    validate_owl @@classification_training_dataset.uri
    validate_owl @@regression_training_dataset.uri
    # ambit datasets do ot validate
    #@datasets.keys.each {|d| validate_owl d }
  end

  def test_from_yaml
    @dataset = OpenTox::Dataset.new
    @dataset.load_yaml(File.open("data/hamster_carcinogenicity.yaml").read)
    hamster_carc?
  end

  def test_rest_csv
    uri = OpenTox::RestClientWrapper.post(CONFIG[:services]["opentox-dataset"],{:file => File.new("data/hamster_carcinogenicity.csv"), :subjectid => @@subjectid}, {:accept => "text/uri-list"}).to_s.chomp
    @dataset = OpenTox::Dataset.new uri
    @dataset.load_all @@subjectid
    hamster_carc?
  end

  def test_multicolumn_csv
    uri = OpenTox::RestClientWrapper.post(CONFIG[:services]["opentox-dataset"],{:file => File.new("data/multicolumn.csv"), :subjectid => @@subjectid}, {:accept => "text/uri-list"}).to_s.chomp
    @dataset = OpenTox::Dataset.new uri
    @dataset.load_all @@subjectid
    assert_equal 5, @dataset.features.size
    assert_equal 4, @dataset.compounds.size
    
  end

  def test_from_csv
    @dataset = OpenTox::Dataset.new
    @dataset.load_csv(File.open("data/hamster_carcinogenicity.csv").read, @@subjectid)
    hamster_carc?
    @dataset.delete(@@subjectid)
  end

  def test_from_excel
    @dataset = OpenTox::Dataset.new
    @dataset.load_spreadsheet(Excel.new("data/hamster_carcinogenicity.xls"), @@subjectid)
    hamster_carc?
    @dataset.delete(@@subjectid)
  end

  def test_load_metadata
    @datasets.each do |uri,data|
      @dataset = OpenTox::Dataset.find(uri, @@subjectid)
      assert @dataset.metadata.size != 0
    end
  end

  def test_load_compounds
    @datasets.each do |uri,data|
      @dataset = OpenTox::Dataset.new(uri)
      @dataset.load_compounds @@subjectid
      assert_equal @dataset.compounds.size,data[:nr_compounds] if data
    end
  end

  def test_load_features
    @datasets.each do |uri,data|
      @dataset = OpenTox::Dataset.new(uri)
      @dataset.load_features @@subjectid
      assert_equal @dataset.features.keys.size,data[:nr_dataset_features] if data
    end
  end

  def test_load_all
    @datasets.each do |uri,data|
      @dataset = OpenTox::Dataset.new(uri)
      @dataset.load_all @@subjectid
      validate data
    end
  end

  def test_yaml
    @datasets.each do |uri,data|
      @dataset = OpenTox::Dataset.new(uri)
      @dataset.load_all @@subjectid
      #@dataset = YAML.load @dataset.to_yaml
      validate data
    end
  end

  def test_csv
    @datasets.each do |uri,data|
      @dataset = OpenTox::Dataset.new(uri)
      @dataset.load_all @@subjectid
      csv = @dataset.to_csv.split("\n")
      assert_equal csv.size, data[:nr_compounds]+1  if data
      assert_equal csv.first.split(", ").size, data[:nr_dataset_features]+1 if data
    end
  end

  def test_excel
    @datasets.each do |uri,data|
      @dataset = OpenTox::Dataset.new(uri)
      @dataset.load_all @@subjectid
      book =  @dataset.to_spreadsheet
      assert_kind_of Spreadsheet::Workbook, book
      #File.open("#{@dataset.id}.xls","w+"){|f| book.write f.path}
    end
  end

  def test_ntriples
    @datasets.each do |uri,data|
      @dataset = OpenTox::Dataset.new(uri)
      @dataset.load_all @@subjectid
      assert_kind_of String, @dataset.to_ntriples
    end
  end

  def test_owl
    @datasets.each do |uri,data|
      @dataset = OpenTox::Dataset.new(uri)
      @dataset.load_all @@subjectid
      assert_kind_of String, @dataset.to_rdfxml
    end
  end
  
#=end
  
  def test_rdf_conversion
    @datasets.each do |uri,data|
      #puts "dataset "+uri.to_s
      @dataset = OpenTox::Dataset.new(uri)
      @dataset.load_all @@subjectid
      
      #puts @dataset.features.keys.size.to_s+" # features"
      #puts "download to rdf"
      f = Tempfile.new("ot-rdf") 
      f.puts @dataset.to_rdfxml
      f.close
      
      #puts "upload as rdf"
      d = OpenTox::Dataset.create(CONFIG[:services]["opentox-dataset"], @@subjectid)
      d.load_rdfxml_file(f)
      f.delete
      d.save(@@subjectid)
      assert d.uri.uri?
      
      #puts "compare"
      dataset_equal(@dataset,d)
      
      #puts "download new dataset as yaml"
      d2 = OpenTox::Dataset.new(d.uri)
      d2.load_all @@subjectid
      
      #puts "compare again"
      dataset_equal(@dataset,d2)
    end
  end
  
=begin
=end
  
  def dataset_equal(d,d2)
    assert d.compounds.sort==d2.compounds.sort,
      d.compounds.sort.to_yaml+"\n!=\n"+d2.compounds.sort.to_yaml
    assert d.features.keys.size==d2.features.keys.size,
      d.features.keys.to_yaml+"\n!=\n"+d2.features.keys.to_yaml
    assert d.features.keys.sort==d2.features.keys.sort,
      d.features.keys.sort.to_yaml+"\n!=\n"+d2.features.keys.sort.to_yaml
    d.compounds.each do |c|
      d.features.keys.each do |f|
        assert_array_about_equal d.data_entries[c][f],d2.data_entries[c][f]
      end
    end
  end
  
  def assert_array_about_equal(a,a2)
    if (a!=nil || a2!=nil)
      raise "no arrays #{a.class} #{a2.class}" unless a.is_a?(Array) and a2.is_a?(Array)
      assert a.size==a2.size
      a.sort! 
      a2.sort!
      a.size.times do |i|
        if (a[i].is_a?(Float) and a2[i].is_a?(Float))
          assert (a[i]-a2[i]).abs<0.0000001,"#{a[i]}(#{a[i].class}) != #{a2[i]}(#{a2[i].class})"
        else
          assert a[i]==a2[i],"#{a[i]}(#{a[i].class}) != #{a2[i]}(#{a2[i].class})"
        end
      end
    end
  end

  def validate(data)
    assert_kind_of OpenTox::Dataset, @dataset
    assert_equal @dataset.data_entries.size, data[:nr_data_entries] if data
    assert_equal @dataset.compounds.size, data[:nr_compounds] if data
    assert_equal @dataset.features.size, data[:nr_dataset_features] if data
    assert_equal @dataset.uri, @dataset.metadata[XSD.anyURI]
  end

  def hamster_carc?
    assert_kind_of OpenTox::Dataset, @dataset
    assert_equal 85, @dataset.data_entries.size
    assert_equal 85, @dataset.compounds.size
    assert_equal @dataset.uri, @dataset.metadata[XSD.anyURI]
  end
end
