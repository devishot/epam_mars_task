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

        if rover.position[:x] > @size[:x] || rover.position[:x] < 0 ||
            rover.position[:y] > @size[:y] || rover.position[:y] < 0

          puts "Rover went beyond Plateau"
          return
        end
      end
    end
  end
end
