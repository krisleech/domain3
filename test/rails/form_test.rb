require_relative '../test_helper'
require 'domain3/form'
require 'active_model'

class FormTest < Minitest::Test
  def subject_class
    Class.new { include Domain3::Form }
  end

  def subject
    subject_class.new
  end

  def test_it_includes_activemodel_in_forms
    assert subject.class.ancestors.include?(ActiveModel::Model)
  end
end
