# frozen_string_literal: true

require 'minitest/autorun'
require 'plan_costs'

class TestPlanCosts < Minitest::Test
  def test_plan_costs_handles_second_lowest
    costs = PlanCosts.new
    costs.add(100)
    costs.add(200)
    costs.add(300)

    assert_equal(200, costs.second_lowest)
  end

  def test_plan_costs_handles_empty
    costs = PlanCosts.new

    assert_nil(costs.second_lowest)
  end

  def test_plan_costs_handles_no_second_lowest
    costs = PlanCosts.new
    costs.add(100)

    assert_nil(costs.second_lowest)
  end

  def test_plan_costs_handles_duplicates
    costs = PlanCosts.new
    costs.add(100)
    costs.add(100)
    costs.add(200)
    costs.add(300)

    assert_equal(200, costs.second_lowest)
  end
end
