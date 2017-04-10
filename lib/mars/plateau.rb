#!/usr/bin/env ruby

require_relative 'rover'

module Mars
  class Plateau
    attr_accessor :size, :rovers, :instructions

    def initialize
      @size = { x: nil, y: nil }
      @rovers = []
      @instructions = []
    end

    def read
      ARGF.each_line.each_with_index { |line, index| parse(line, index) }
    end

    def process!
      @rovers.zip(@instructions).each { |rover, actions| process_rover(rover, actions) }
    end

    def write
      @rovers.each { |rover| puts rover }
    end

    private

    def process_rover(rover, actions)
      actions.each do |action|
        rover.process!(action)

        if rover.position[:x] > @size[:x] || rover.position[:y] > @size[:y]
          puts "Rover went beyond Plateau"
          return
        end
      end
    end

    def parse_points(line)
      str = line.chomp.split(' ')
      begin
        { x: str.fetch(0).to_i, y: str.fetch(1).to_i }
      rescue IndexError
        puts "Cannot read points, expected two points"
      rescue ArgumentError
        puts "Cannot read points, expected Integer values"
      end
    end

    def parse_rover(line)
      points = parse_points(line)
      return if points.nil?

      str = line.chomp.split(' ')
      direction = nil

      begin
        direction = DIRECTIONS.invert.fetch(str.fetch(2))
      rescue IndexError
        puts "Cannot read rover orientation, expected char"
      rescue KeyError
        puts "Cannot read rover orientation, expected values: N, E, S, W"
      end

      return if direction.nil?
      Rover.new(points, direction)
    end

    def parse_instruction(line)
      actions = line.chomp.chars

      if actions.reject { |t| %w(L R M).include?(t) }.count > 0
        actions = nil
        puts "Cannot read rover instruction, expected sequence of: L, R, M"
      end

      actions
    end

    def parse(line, index)
      if index == 0
        @size = parse_points(line)
      elsif index % 2 == 1
        @rovers << parse_rover(line)
      else
        @instructions << parse_instruction(line)
      end
    end

  end
end
