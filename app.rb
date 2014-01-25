#!/usr/bin/env ruby

require_relative "employee"
require_relative "availability"
require_relative "required"

require 'pry'
require 'byebug'

availability = Availability::EmployeeAvailability.new
required_hours = RequiredWork::WeeklyDemand.new
binding.pry

