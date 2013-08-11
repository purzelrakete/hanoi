$: << File.expand_path(File.dirname(__FILE__))

require 'coveralls'
Coveralls.wear!

require 'render'
require 'search'
require 'problem'
require 'node'
require "test/unit"

class TestHanoi < Test::Unit::TestCase
   def setup
    @problem = Problem.new(disks = 3 , pegs = 5)
    @search  = Search.new(@problem)
  end

  def test_result
    goal = @search.run
    assert_equal([[], [], [], [], [1, 2, 3]], goal.state)
  end

  def test_render
    goal = @search.run
    slides = Render.new(@problem, goal).slides
    assert_equal(slides.first, "1....\n2....\n3....")
    assert_equal(slides.last, "....1\n....2\n....3")
  end
end
