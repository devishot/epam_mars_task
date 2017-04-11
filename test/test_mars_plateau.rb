require 'minitest/autorun'
require_relative '../lib/mars/plateau'


class TestRover < MiniTest::Test
  def setup
    @plateau = Mars::Plateau.new
    @plateau.size = { x: 5, y: 5 }
    @plateau.rovers << Mars::Rover.new({ x: 1, y: 2 }, :north)
    @plateau.instructions << "LMLMLMLMM".chars
  end

  def test_process
    @plateau.process!
    assert_equal("1 3 N", @plateau.rovers.first.to_s )
  end

  def test_beyond_size
    @plateau.instructions = ["MMMM".chars]

    mock = MiniTest::Mock.new
    mock.expect(:puts, nil, ["Rover went beyond Plateau"])
    @plateau.stub(:puts, -> (args) { mock.puts args.to_s } ) { @plateau.process! }
    assert mock.verify
  end

  def test_write
    mock = MiniTest::Mock.new
    mock.expect(:puts, nil, ["1 2 N"])
    @plateau.stub(:puts, -> (args) { mock.puts args.to_s } ) { @plateau.write }
    assert mock.verify
  end
end
