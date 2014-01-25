#!/usr/bin/env ruby

require_relative "employee"
require_relative "availability"

require 'pry'

availability = Availability::EmployeeAvailability.new

binding.pry
