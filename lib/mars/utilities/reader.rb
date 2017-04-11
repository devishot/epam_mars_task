#!/usr/bin/env ruby
require_relative 'builder'

module Mars
  module Utilities
    class Reader
      attr_accessor :builder

      def initialize(builder)
        @builder = builder
      end

      def read(io = ARGF)
        io.each_line.each_with_index { |line, index| parse(line, index) }
      end

      def result
        @builder.plateau
      end

      private

      def parse(line, index)
        if index == 0
          point = parse_point(line)
          @builder.set_size(point)
        elsif index % 2 == 1
          point, direction = parse_rover(line)
          @builder.add_rover(point, direction)
        else
          instruction = parse_instruction(line)
          @builder.add_instruction(instruction)
        end
      end

      def parse_point(str)
        arr = str.chomp.split(' ')
        begin
          { x: arr.fetch(0).to_i, y: arr.fetch(1).to_i }
        rescue IndexError
          puts "Cannot read points, expected two points"
        rescue ArgumentError
          puts "Cannot read points, expected Integer values"
        end
      end

      def parse_rover(str)
        point = parse_point(str)
        return [] if point.nil?

        arr = str.chomp.split(' ')
        direction = nil

        begin
          direction = DIRECTIONS.invert.fetch(arr.fetch(2))
        rescue IndexError
          puts "Cannot read rover orientation, expected char"
        rescue KeyError
          puts "Cannot read rover orientation, expected values: N, E, S, W"
        end

        return [] if direction.nil?
        [point, direction]
      end

      def parse_instruction(str)
        if /[^LRM]/.match(str.chomp).nil?
          str.chomp.chars
        else
          puts "Cannot read rover instruction, expected sequence of: L, R, M"
        end
      end
    end
  end
end
