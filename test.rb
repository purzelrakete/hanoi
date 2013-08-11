$: << File.expand_path(File.dirname(__FILE__))

require 'render'
require 'search'
require 'problem'
require 'node'
require "test/unit"
require 'coveralls'

Coveralls.wear!

class TestHanoi < Test::Unit::TestCase
  def test_result
    problem = Problem.new(disks = 3 , pegs = 5)
    search  = Search.new(problem)
    goal = search.run
    assert_equal([[], [], [], [], [1, 2, 3]], goal.state)
  end
end
