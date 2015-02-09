require_relative 'test_helper'
require 'domain3/form'

class FormTest < Minitest::Test
  def subject_class
    Class.new { include Domain3::Form }
  end

  def subject
    subject_class.new
  end

  def test_it_includes_virtus
    assert subject.class.ancestors.include?(Virtus::Model::Core)
  end
end
