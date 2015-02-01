require 'minitest/autorun'
require 'domain3/service'

class ServiceTest < Minitest::Test
  def test_it_includes_publishing
    subject =  Class.new { include Service }

    assert subject.ancestors.include?(Wisper::Publisher)
  end
end
