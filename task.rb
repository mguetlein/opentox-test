require 'rubygems'
require 'opentox-ruby'
require 'test/unit'
require "./validate-owl.rb"

class TaskTest < Test::Unit::TestCase

  def setup
  end

  def teardown
  end

  def test_create_and_complete
    task = OpenTox::Task.create { "http://test.org"}
    assert_equal task.status, "Running"
    task.wait_for_completion
    assert_equal task.status, "Completed"
  end


  def test_rdf
    task = OpenTox::Task.new OpenTox::Task.all.last
    validate_owl(task.uri)
    #puts task.uri
  end
=begin
=end

end
