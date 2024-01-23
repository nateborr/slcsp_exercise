# frozen_string_literal: true

require 'minitest/autorun'
require 'slc_finder'

class TestSlcFinder < Minitest::Test
  def setup
    @finder = SlcFinder.new(setup_slcsp_data)

    @zipcodes_to_rate_areas = {
      '12345' => 'AA 1',
      '12346' => 'BB 2',
      '12347' => 'ambiguous'
    }

    @rate_areas_to_plan_costs = setup_rate_areas_to_plan_costs
  end

  def test_update_table_handles_slc_present
    @finder.update_table!(@zipcodes_to_rate_areas, @rate_areas_to_plan_costs)

    row0 = @finder.slcsp_table[0]
    assert_equal('12345', row0['zipcode'])
    assert_equal('300.00', row0['rate'])
  end

  def test_update_table_handles_slc_absent
    @finder.update_table!(@zipcodes_to_rate_areas, @rate_areas_to_plan_costs)

    row1 = @finder.slcsp_table[1]
    assert_equal('12346', row1['zipcode'])
    assert_nil(row1['rate'])
  end

  def test_update_table_handles_ambiguous_rate_area
    @finder.update_table!(@zipcodes_to_rate_areas, @rate_areas_to_plan_costs)

    row2 = @finder.slcsp_table[2]
    assert_equal('12347', row2['zipcode'])
    assert_nil(row2['rate'])
  end

  private

  def setup_slcsp_data
    raw_plans_data = <<~CSV
      zipcode,rate
      12345,
      12346,
      12347
    CSV

    CSV.parse(raw_plans_data, headers: true)
  end

  def setup_rate_areas_to_plan_costs
    aa1_plan_costs = PlanCosts.new
    aa1_plan_costs.add(200.0)
    aa1_plan_costs.add(300.0)
    aa1_plan_costs.add(400.0)

    {
      'AA 1' => aa1_plan_costs,
      'BB 2' => PlanCosts.new
    }
  end
end
