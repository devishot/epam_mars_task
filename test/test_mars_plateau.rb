require 'minitest/autorun'
require_relative '../lib/mars/plateau'


class TestPlateau < MiniTest::Test

  def setup
    @plateau = Mars::Plateau.new
  end

  def test_read_size
    io = StringIO.new("5 5\n1 2 N\nLMLMLMLMM")
    ARGF.stub(:each_line, io) { @plateau.read }

    assert_equal({ x: 5, y: 5 }, @plateau.size)
    assert_equal(1, @plateau.rovers.count)
  end

  def test_read_rovers
    io = StringIO.new("5 5\n1 2 N\nLMLMLMLMM")
    ARGF.stub(:each_line, io) { @plateau.read }

    assert_equal(1, @plateau.rovers.count)
  end

  def test_read_instructions
    io = StringIO.new("5 5\n1 2 N\nLMLMLMLMM")
    ARGF.stub(:each_line, io) { @plateau.read }

    assert_equal(1, @plateau.instructions.count )
    assert_equal("LMLMLMLMM".chars, @plateau.instructions.first)
  end

  def test_read_size_fail
    io = StringIO.new("5\n")
    mock = MiniTest::Mock.new
    mock.expect(:puts, nil, ["Cannot read points, expected two points"])

    @plateau.stub(:puts, -> (args) { mock.puts args }) do
      ARGF.stub(:each_line, io) { @plateau.read }
    end

    assert mock.verify
  end

  def test_read_instructions_fail
    io = StringIO.new("5 5\n1 2 N\nAMLMLMLMA")
    mock = MiniTest::Mock.new
    mock.expect(:puts, nil, ["Cannot read rover instruction, expected sequence of: L, R, M"])

    @plateau.stub(:puts, -> (args) { mock.puts args }) do
      ARGF.stub(:each_line, io) { @plateau.read }
    end

    assert mock.verify
  end

  def test_process
    io = StringIO.new("5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM")
    ARGF.stub(:each_line, io) { @plateau.read }
    @plateau.process!

    assert_equal("1 3 N", @plateau.rovers.first.to_s )
    assert_equal("5 1 E", @plateau.rovers.last.to_s )
  end

  def test_beyond_size
    io = StringIO.new("5 5\n1 2 N\nMMMM")
    mock = MiniTest::Mock.new
    mock.expect(:puts, nil, ["Rover went beyond Plateau"])

    @plateau.stub(:puts, -> (args) { mock.puts args.to_s }) do
      ARGF.stub(:each_line, io) { @plateau.read }
      @plateau.process!
    end

    assert mock.verify
  end

  def test_process_and_write
    io = StringIO.new("5 5\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM")
    mock = MiniTest::Mock.new
    mock.expect(:puts, nil, ["1 3 N"])
    mock.expect(:puts, nil, ["5 1 E"])

    @plateau.stub(:puts, -> (args) { mock.puts args.to_s }) do
      ARGF.stub(:each_line, io) { @plateau.read }
      @plateau.process!
      @plateau.write
    end

    assert mock.verify
  end
end
