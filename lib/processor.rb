# frozen_string_literal: true

require 'csv'

require 'rate_areas_to_plan_costs_mapper'
require 'zipcode_to_rate_area_mapper'

# Perform all the logic to calculate and output SLCSP rates
class Processor
  PLANS_CSV_PATH = './data/plans.csv'
  SLCSP_CSV_PATH = './data/slcsp.csv'
  ZIPS_CSV_PATH = './data/zips.csv'

  class << self
    def process!
      slcsp_data = CSV.read(SLCSP_CSV_PATH, headers: true)
      zips_data = CSV.read(ZIPS_CSV_PATH, headers: true)
      plans_data = CSV.read(PLANS_CSV_PATH, headers: true)

      zipcodes_to_rate_areas = ZipcodeToRateAreaMapper.new(zips_data).map
      rate_areas_to_plan_costs = RateAreasToPlanCostsMapper.new(plans_data).map

      puts 'todo'
    end
  end
end
