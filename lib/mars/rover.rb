#!/usr/bin/env ruby

module Mars
  DIRECTIONS = { north: 'N', east: 'E', south: 'S', west: 'W' }

  class Rover
    attr_accessor :position, :direction

    def initialize(position, direction)
      @position = position
      @direction = direction
    end

    def to_s
      "#{@position[:x]} #{@position[:y]} #{DIRECTIONS[@direction]}"
    end

    def move!
      case @direction
      when :north
        @position[:y] += 1
      when :east
        @position[:x] += 1
      when :south
        @position[:y] -= 1
      when :west
        @position[:x] -= 1
      end

      @position
    end

    def rotate!(spin_direction)
      inc = spin_direction == 'L' ? -1 : 1
      keys = DIRECTIONS.keys
      index = keys.index(@direction)
      count = keys.count
      @direction = keys[(count + index + inc) % count]
    end

    def process!(action)
      if action == 'M'
        move!
      elsif ['L', 'R'].include?(action)
        rotate!(action)
      end

      self
    end

  end
end
