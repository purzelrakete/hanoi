#
# Frontier nodes
#

class Node
  attr_accessor :state, :parent, :action, :path_cost

  def initialize(parent, state, step_cost, action = nil)
    @parent = parent
    @state = state
    @action = action
    @path_cost = parent_path_cost + step_cost + heuristic
  end

  def path
    parent_path + [@state]
  end

  def heuristic
    state[0].size + state[1].size
  end

  def <=>(other)
    path_cost <=> other.path_cost
  end

  private

    def parent_path_cost
      @parent ? @parent.path_cost : 0
    end

    def parent_path
      @parent ? @parent.path : []
    end
end

