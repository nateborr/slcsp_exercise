# frozen_string_literal: true

require 'minitest/autorun'
require 'zipcode_to_rate_area_mapper'

class TestZipcodeToRateAreaMapper < Minitest::Test
  def setup
    @mapper = ZipcodeToRateAreaMapper.new(setup_zips_data)
  end

  def test_map_zipcodes_to_rate_areas_handles_all_zips
    zipcode_to_area_map = @mapper.map
    assert_equal(%w[12345 12346 12347 12348], zipcode_to_area_map.keys.sort)
  end

  def test_map_zipcodes_to_rate_areas_handles_one_to_one_mappings
    zipcode_to_area_map = @mapper.map
    assert_equal('AA 1', zipcode_to_area_map['12345'])
    assert_equal('AA 2', zipcode_to_area_map['12346'])
  end

  def test_map_zipcodes_to_rate_areas_handles_multiple_counties
    zipcode_to_area_map = @mapper.map
    assert_equal('BB 3', zipcode_to_area_map['12347'])
  end

  def test_map_zipcodes_to_rate_areas_handles_ambiguous_rate_areas
    zipcode_to_area_map = @mapper.map
    assert_equal('ambiguous', zipcode_to_area_map['12348'])
  end

  private

  def setup_zips_data
    raw_zips_data = <<~CSV
      zipcode,state,county_code,name,rate_area
      12345,AA,00000,County0,1
      12346,AA,00001,County1,2
      12347,BB,00002,County2,3
      12347,BB,00003,County3,3
      12348,BB,00004,County4,4
      12348,BB,00005,County5,5
    CSV

    CSV.parse(raw_zips_data, headers: true)
  end
end
