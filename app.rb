#!/usr/bin/env ruby

require_relative "employee"
require_relative "availability"
require_relative "required"

require 'pry'
require 'byebug'

module MotionlessAgitator

    availability = EmployeeAvailability.new
    required_hours = WeeklyDemand.new

    Renderer.new(@availability, @required_hours).convert

end

