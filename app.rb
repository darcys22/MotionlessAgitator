#!/usr/bin/env ruby

require_relative "day"
require_relative "availability"
require_relative "weeklydemand"
require_relative "render"
require_relative "schedule"
require_relative "dailyplanner"
require_relative "observer"

require 'pry'
require 'byebug'

module MotionlessAgitator

    availability = EmployeeAvailability.new
    required_hours = WeeklyDemand.new

    Renderer.new(availability, required_hours).render!

end

