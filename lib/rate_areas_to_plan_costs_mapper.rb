# frozen_string_literal: true

require 'plan_costs'

# From a CSV table of plan data, produce a map of rate areas (string) to plan costs (float)
class RateAreasToPlanCostsMapper
  attr_accessor :plans_data

  HEADER_METAL_LEVEL = 'metal_level'
  HEADER_RATE = 'rate'
  HEADER_RATE_AREA = 'rate_area'
  HEADER_STATE = 'state'
  METAL_LEVEL_SILVER = 'Silver'

  def initialize(plans_data)
    self.plans_data = plans_data
  end

  def map
    areas_to_costs = {}

    plans_data.each do |row|
      map_row!(areas_to_costs, row)
    end

    areas_to_costs
  end

  private

  def map_row!(map, row)
    metal_level = row[HEADER_METAL_LEVEL]

    # Ignore non-Silver plans
    return unless metal_level == METAL_LEVEL_SILVER

    cost = row[HEADER_RATE]
    state = row[HEADER_STATE]
    rate_area = row[HEADER_RATE_AREA]
    rate_area_key = get_rate_area_key(state, rate_area)

    # Initialize the plan costs for the rate area if needed
    map[rate_area_key] = PlanCosts.new if map[rate_area_key].nil?

    map[rate_area_key].add(cost.to_f)
  end

  def get_rate_area_key(state, rate_area)
    "#{state} #{rate_area}"
  end
end
