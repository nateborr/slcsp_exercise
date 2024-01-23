# frozen_string_literal: true

require 'csv'

require 'rate_areas_to_plan_costs_mapper'
require 'slc_finder'
require 'zipcode_to_rate_area_mapper'

# Perform all the logic to calculate and output SLCSP rates
class Processor
  PLANS_CSV_PATH = './data/plans.csv'
  SLCSP_CSV_PATH = './data/slcsp.csv'
  ZIPS_CSV_PATH = './data/zips.csv'

  class << self
    def process!
      # Import CSV::Table instances for the three input files
      slcsp_data = CSV.read(SLCSP_CSV_PATH, headers: true)
      zips_data = CSV.read(ZIPS_CSV_PATH, headers: true)
      plans_data = CSV.read(PLANS_CSV_PATH, headers: true)

      # Generate hashes that map:
      # 1. each zipcode to its rate area, or 'ambiguous'
      # 2. each rate area to its set of unique rates, wrapped in a PlanCost instance
      zipcodes_to_rate_areas = ZipcodeToRateAreaMapper.new(zips_data).map
      rate_areas_to_plan_costs = RateAreasToPlanCostsMapper.new(plans_data).map

      # Look up and format the second-lowest cost plan rate, if any,
      # for each zip code in the SLCSP csv table and add it to the table data
      slc_finder = SlcFinder.new(slcsp_data)
      slc_finder.update_table!(zipcodes_to_rate_areas, rate_areas_to_plan_costs)

      # Print the updated SLCSP csv table to stdout
      puts slcsp_data.to_csv
    end
  end
end
