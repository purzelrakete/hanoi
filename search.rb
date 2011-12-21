require 'set'

#
# A* Best first graph search
#

class Search
  attr_accessor :disks

  def initialize(disks, pegs = 4)
    @disks = disks
    @pegs = pegs

    @initial = [(1..@disks).to_a] + [[]] * (pegs - 1)
    @goal = [[]] * (pegs - 1) + [(1..@disks).to_a]

    @frontier = SortedSet.new([Node.new(nil, @initial, cost = 1)])
    @explored = {}
  end

  def actions(state)
    all_moves.select { |action| legal?(state, *action) }
  end

  def legal?(state, from, to)
    (top(state[from]) < top(state[to]))
  end

  def move(state, from, to)
    res = clone(state).tap do |s_prime|
      s_prime[to].unshift(s_prime[from].shift)
    end
  end

  def top(peg)
    peg.first || @disks + 1
  end

  def choose
    @frontier.first.tap do |selection|
      @frontier.delete(selection)
      @explored[selection.state] = 1
    end
  end

  def seen?(state)
    @explored[state] || @frontier.map { |n| n.state }.include?(state)
  end

  def explored
    @explored.keys.size
  end

  def search
    loop do
      return false if @frontier.empty?

      choose.tap do |node|
        return node if node.state == @goal

        actions(node.state).each do |action|
          s_prime = move(node.state, *action)

          unless seen?(s_prime)
            @frontier << Node.new(node, s_prime, cost = 1, action)
          end
        end
      end
    end
  end

  private

    def all_moves
      @p ||= (0...@pegs).to_a.permutation([:from, :to].size).to_a
    end

    def clone(state)
      state.map { |s| Array.new(s) }
    end
end

