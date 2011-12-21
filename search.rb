require 'set'

#
# Graph search
#

class Search
  def initialize(problem)
    @frontier = SortedSet.new([Node.new(problem.initial)])
    @problem = problem
    @explored = {}
  end

  def run
    loop do
      return false if @frontier.empty?

      pop.tap do |node|
        return node if @problem.goal?(node.state)
        add_to_explored(node)

        node.expand(@problem).each do |n_prime|
          add_to_frontier(n_prime) unless seen?(n_prime)
        end
      end
    end
  end

  def explored_size
    @explored.keys.size
  end

  private

    def add_to_explored(node)
      @explored[node.state] = 1
    end

    def add_to_frontier(node)
      @frontier << node
    end

    def pop
      @frontier.first.tap do |node|
        @frontier.delete(node)
      end
    end

    def seen?(node)
      @explored[node.state] || @frontier.map(&:state).include?(node.state)
    end
end

