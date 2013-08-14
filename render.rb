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
  end

  def animate
    init_screen

    slides.each do |slide|
      render slide
      getch
    end

    ensure getch && close_screen
  end

  def slides
    @solution.path.map do |state|
      rows(Matrix[*state.map { |peg| padded(peg) }].transpose).join("\n")
    end
  end

  private
  def render(slide)
    setpos(0, 0)
    addstr(slide)
    refresh
  end

  def rows(matrix)
    (0...matrix.row_size).map do |row|
       matrix.row(row).to_a.map { |cell| pixel(cell) }.join
    end
  end

  def padded(peg)
    ([0] * (@problem.disks - peg.size)) + peg
  end

  def pixel(n)
    n > 0 ? n.to_s : "."
  end
end
