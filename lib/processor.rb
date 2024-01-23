# frozen_string_literal: true

require 'csv'

require 'zipcode_to_rate_area_mapper'

# Perform all the logic to calculate and output SLCSP rates
class Processor
  SLCSP_CSV_PATH = './data/slcsp.csv'
  ZIPS_CSV_PATH = './data/zips.csv'

  class << self
    def process!
      slcsp_data = CSV.read(SLCSP_CSV_PATH, headers: true)
      zips_data = CSV.read(ZIPS_CSV_PATH, headers: true)

      zipcode_to_rate_area_mapper = ZipcodeToRateAreaMapper.new(zips_data)
      zipcodes_to_rate_areas = zipcode_to_rate_area_mapper.map

      puts 'todo'
    end
  end
end
