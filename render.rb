require 'curses'
require 'matrix'

#
# Curses hanoi rendering
#

class Render
  include Curses

  def initialize(problem, solution)
    @problem = problem
    @solution = solution

    @x = 2
    @y = 1

    init_screen
  end

  def animate
    @solution.path.each do |state|
      render Matrix[*state.map { |peg| padded(peg) }].transpose
      getch
    end

    ensure getch && close_screen
  end

  def padded(peg)
    ([0] * (@problem.disks - peg.size)) + peg
  end

  def render(state)
    @problem.disks.times do |n|
      setpos(n + @y, @x)
      addstr state.row(n).to_a.map { |n| n > 0 ? n.to_s : "." }.join("")
      refresh
    end
  end
end

