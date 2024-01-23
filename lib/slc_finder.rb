# frozen_string_literal: true

# Update an SLCSP CSV table in-place with second-lowest plan rate values.
class SlcFinder
  AMBIGUOUS_RATE_AREA_KEY = 'ambiguous'
  HEADER_RATE = 'rate'
  HEADER_ZIPCODE = 'zipcode'

  attr_accessor :slcsp_table

  def initialize(slcsp_table)
    self.slcsp_table = slcsp_table
  end

  # Add rate values based on two maps:
  # 1. zipcodes to rate areas
  # 2. rate areas to PlanCosts instances
  def update_table!(zipcodes_to_rate_areas, rate_areas_to_plan_costs)
    slcsp_table.each do |row|
      zipcode = row[HEADER_ZIPCODE]
      rate_area = zipcodes_to_rate_areas[zipcode]
      plan_costs = rate_area == AMBIGUOUS_RATE_AREA_KEY ? nil : rate_areas_to_plan_costs[rate_area]
      row[HEADER_RATE] = get_slc_text(plan_costs)
    end
  end

  private

  # For a PlanCosts instance (possibly nil), get the rate string to add to the CSV table
  def get_slc_text(plan_costs)
    slc = plan_costs&.second_lowest

    slc.nil? ? nil : format('%.2f', slc)
  end
end
