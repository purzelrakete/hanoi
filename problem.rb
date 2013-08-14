#
# Hanoi problem formulation
#

class Problem
  attr_accessor :initial, :goal, :disks, :pegs

  def initialize(disks, pegs, initial = nil, goal = nil)
    @disks = disks
    @pegs = pegs
    @initial = initial || default_opening(disks, pegs)
    @goal = goal || default_closing(disks, pegs)
  end

  def actions(state)
    permutations.select { |action| applicable?(state, action) }
  end

  def applicable?(state, action)
    from, to = action
    top(state[from]) < top(state[to])
  end

  def goal?(state)
    state == @goal
  end

  def heuristic_cost(state)
    state[0].size + state[1].size
  end

  def step_cost(state, action, s_prime)
    cost = 1
  end

  def result(state, action)
    from, to = action
    clone(state).tap do |s_prime|
      s_prime[to].unshift(s_prime[from].shift)
    end
  end

  private
  def clone(state)
    state.map { |s| Array.new(s) }
  end

  def default_closing(disks, pegs)
    peg(0) * (pegs - 1) + peg(disks)
  end

  def default_opening(disks, pegs)
    peg(disks) + peg(0) * (pegs - 1)
  end

  def peg(n)
    [n > 0 ? (1..n).to_a : []]
  end

  def permutations
    @p ||= (0...@pegs).to_a.permutation([:from, :to].size).to_a
  end

  def top(peg)
    peg.first || @disks + 1
  end
end
