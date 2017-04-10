require 'minitest/autorun'
require_relative '../lib/mars/rover'


class TestRover < MiniTest::Test
  def setup
    @rover_north = Mars::Rover.new({ x: 1, y: 3 }, :north)
    @rover_south = Mars::Rover.new({ x: 1, y: 3 }, :south)
    @rover_west = Mars::Rover.new({ x: 1, y: 3 }, :west)
    @rover_east = Mars::Rover.new({ x: 1, y: 3 }, :east)
  end

  def test_simple
    assert_equal('1 3 N', @rover_north.to_s )
  end

  def test_move
    assert_equal({ x: 1, y: 4 }, @rover_north.move! )
    assert_equal({ x: 1, y: 2 }, @rover_south.move! )
    assert_equal({ x: 0, y: 3 }, @rover_west.move! )
    assert_equal({ x: 2, y: 3 }, @rover_east.move! )
  end

  def test_rotate_left
    assert_equal(:west, @rover_north.rotate!('L') )
    assert_equal(:east, @rover_south.rotate!('L') )
    assert_equal(:south, @rover_west.rotate!('L') )
    assert_equal(:north, @rover_east.rotate!('L') )
  end

  def test_rotate_right
    assert_equal(:east, @rover_north.rotate!('R') )
    assert_equal(:west, @rover_south.rotate!('R') )
    assert_equal(:north, @rover_west.rotate!('R') )
    assert_equal(:south, @rover_east.rotate!('R') )
  end

  def test_process
    assert_equal('1 4 N', @rover_north.process!('M').to_s )
  end

end
