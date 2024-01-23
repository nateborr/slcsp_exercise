# frozen_string_literal: true

require 'minitest/autorun'
require 'rate_areas_to_plan_costs_mapper'

class TestRateAreasToPlanCostsMapper < Minitest::Test
  def setup
    @mapper = RateAreasToPlanCostsMapper.new(setup_plans_data)
  end

  def test_map_handles_all_rate_areas
    map = @mapper.map

    assert_kind_of(PlanCosts, map['AA 1'])
    assert_kind_of(PlanCosts, map['BB 2'])
    assert_kind_of(PlanCosts, map['CC 3'])
  end

  # These tests depend on the PlanCost class's behavior to calculate the second-lowest plan cost.
  # This is less brittle than making assertions of the messages sent to PlanCosts instances,
  # at the expense of poorer separation of concerns.
  def test_map_handles_costs_as_floats
    map = @mapper.map

    assert_equal(300.0, map['AA 1'].second_lowest)
  end

  def test_map_includes_only_silver_plans
    map = @mapper.map

    assert_equal(400.0, map['BB 2'].second_lowest)
    assert_nil(map['CC 3'].second_lowest)
  end

  private

  def setup_plans_data # rubocop:disable Metrics/MethodLength
    raw_plans_data = <<~CSV
      plan_id,state,metal_level,rate,rate_area
      11111111111111,AA,Silver,200.00,1
      22222222222222,AA,Silver,300.00,1
      33333333333333,AA,Silver,400.00,1
      44444444444444,BB,Bronze,200.00,2
      55555555555555,BB,Silver,300.00,2
      66666666666666,BB,Silver,400.00,2
      77777777777777,BB,Gold,500.00,2
      88888888888888,CC,Bronze,200.00,3
      99999999999999,CC,Silver,300.00,3
    CSV

    CSV.parse(raw_plans_data, headers: true)
  end
end
