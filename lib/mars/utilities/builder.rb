#!/usr/bin/env ruby
require_relative '../plateau'

module Mars
  module Utilities
    class Builder
      attr_accessor :plateau

      def initialize
        @plateau = Mars::Plateau.new
      end

      def set_size(point)
        if point[:x] < 0 || point[:y] < 0
          puts "Upper-right coordinates can't be negative values"
        else
          @plateau.size = point
        end
      end

      def add_rover(point, direction)
        if point[:x] > @plateau.size[:x] || point[:x] < 0 ||
            point[:y] > @plateau.size[:y] || point[:y] < 0

          puts "Rover coordinates are not in the Plateau"
        elsif @plateau.rovers.index { |rover| rover.position == point }
          puts "Landing place has already taken"
        else
          @plateau.rovers << Rover.new(point, direction)
        end
      end

      def add_instruction(actions)
        @plateau.instructions << actions
      end
    end
  end
end
