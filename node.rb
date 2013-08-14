#
# Frontier nodes
#

class Node
  attr_accessor :state, :path_cost

  def initialize(state, action = nil, path_cost = 0, parent = nil)
    @state = state
    @action = action
    @path_cost = path_cost
    @parent = parent
  end

  def expand(problem)
    problem.actions(@state).map do |action|
      Node.create(self, problem, action)
    end
  end

  def path
    parent_path + [@state]
  end

  def <=>(other)
    path_cost <=> other.path_cost
  end

  #
  # Factory
  #

  def self.create(parent, problem, action)
    result = problem.result(parent.state, action)

    cost = \
      parent.path_cost +
      problem.step_cost(parent.state, action, result) +
      problem.heuristic_cost(result)

    Node.new(result, action, cost, parent)
  end

  private
  def parent_path
    @parent ? @parent.path : []
  end
end
