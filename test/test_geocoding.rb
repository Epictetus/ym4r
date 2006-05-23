$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'ym4r'
require 'test/unit'

include Ym4r::BuildingBlock

class TestGeocoding< Test::Unit::TestCase

  def test_apple
    results1 = Geocoding::get(:street => "1 Infinite Loop",
                             :city => "Cupertino",
                             :state => "CA",
                             :zip => "95014")
    assert_equal(1,results1.length)
    result1 = results1[0]
    assert(result1.exact_match?)
    assert_equal("address",result1.precision)

    results2 = Geocoding::get(:location => "1 Infinite Loop Cupertino CA 95014")
    assert_equal(1,results2.length)
    result2 = results2[0]
    assert(result2.exact_match?)
    
    assert_equal(result1.latitude,result2.latitude)
    assert_equal(result1.longitude,result2.longitude)
  end

  def test_garbage_location
    assert_raise(Ym4r::BadRequestException) {Geocoding::get(:location => "AZEAEAEAEAEAE")}
  end

  def test_no_location
    assert_raise(Ym4r::MissingParameterException) {Geocoding::get(:hello => "world")}
  end
  
end
