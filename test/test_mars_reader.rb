require 'minitest/autorun'
require_relative '../lib/mars/utilities/reader'
require_relative '../lib/mars/utilities/builder'

class TestReader < MiniTest::Test

  def setup
    @builder = Mars::Utilities::Builder.new
    @reader = Mars::Utilities::Reader.new(@builder)
  end

  def test_read_size
    io = StringIO.new("5 5\n1 2 N\nLMLMLMLMM")
    @reader.read(io)
    plateau = @reader.result
    assert_equal({ x: 5, y: 5 }, plateau.size)
  end

  def test_read_rovers
    io = StringIO.new("5 5\n1 2 N\nLMLMLMLMM")
    @reader.read(io)
    plateau = @reader.result
    assert_equal(1, plateau.rovers.count)
  end

  def test_read_instructions
    io = StringIO.new("5 5\n1 2 N\nLMLMLMLMM")
    @reader.read(io)
    plateau = @reader.result
    assert_equal(1, plateau.instructions.count )
    assert_equal("LMLMLMLMM".chars, plateau.instructions.first)
  end

  def test_read_size_fail
    io = StringIO.new("5\n")
    mock = MiniTest::Mock.new
    mock.expect(:puts, nil, ["Cannot read points, expected two points"])

    @reader.stub(:puts, -> (args) { mock.puts args }) { @reader.read(io) }

    assert mock.verify
  end

  def test_read_rover_fail
    io = StringIO.new("5 5\n1 2 N\nMM\n1 2 N\nMM")
    mock = MiniTest::Mock.new
    mock.expect(:puts, nil, ["Landing place has already taken"])

    @builder.stub(:puts, -> (args) { mock.puts args }) { @reader.read(io) }

    assert mock.verify
  end

  def test_read_instructions_fail
    io = StringIO.new("5 5\n1 2 N\nAMLMLMLMA")
    mock = MiniTest::Mock.new
    mock.expect(:puts, nil, ["Cannot read rover instruction, expected sequence of: L, R, M"])

    @reader.stub(:puts, -> (args) { mock.puts args }) { @reader.read(io) }

    assert mock.verify
  end
end
