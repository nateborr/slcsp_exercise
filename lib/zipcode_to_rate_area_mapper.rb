# frozen_string_literal: true

require 'csv'

# From a CSV table of zipcode data, produce a map of zipcodes to rate areas
class ZipcodeToRateAreaMapper
  attr_accessor :zips_data

  AMBIGUOUS_RATE_AREA_KEY = 'ambiguous'
  HEADER_RATE_AREA = 'rate_area'
  HEADER_STATE = 'state'
  HEADER_ZIPCODE = 'zipcode'

  def initialize(zips_data)
    self.zips_data = zips_data
  end

  def map
    map = {}

    zips_data.each do |row|
      map_zipcode_row!(map, row)
    end

    map
  end

  private

  def map_zipcode_row!(map, row)
    zipcode = row[HEADER_ZIPCODE]
    state = row[HEADER_STATE]
    rate_area = row[HEADER_RATE_AREA]
    rate_area_key = get_rate_area_key(state, rate_area)

    existing_key = map[zipcode]
    ambiguous_rate_area = existing_key && (existing_key != rate_area_key)
    map[zipcode] = ambiguous_rate_area ? AMBIGUOUS_RATE_AREA_KEY : rate_area_key
  end

  def get_rate_area_key(state, rate_area)
    "#{state} #{rate_area}"
  end
end
