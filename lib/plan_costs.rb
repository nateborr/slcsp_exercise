# frozen_string_literal: true

# Set is builtin as of Ruby 3.2 but explicitly require it to provide backwards compatiblity
require 'set' # rubocop:disable Lint/RedundantRequireStatement

# Determine the second-lowest of a set of plan costs, if any
class PlanCosts
  def initialize
    self.cost_set = Set.new
  end

  def add(cost)
    cost_set.add(cost)
  end

  def second_lowest
    cost_array = cost_set.to_a
    cost_array.length < 2 ? nil : cost_array.sort[1]
  end

  private

  attr_accessor :cost_set
end
