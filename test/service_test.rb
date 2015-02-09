require_relative 'test_helper'
require 'domain3/service'

class ServiceTest < Minitest::Test

  def test_it_includes_wisper_publisher
    assert subject.class.ancestors.include?(Wisper::Publisher)
  end

  def test_it_includes_medicine
    assert subject.class.ancestors.include?(Medicine::DI)
  end

  private

  def subject_class
    Class.new { include Domain3::Service }
  end

  def subject
    subject_class.new
  end
end
