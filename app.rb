#!/usr/bin/env ruby

require 'csv'
require_relative "employee"

csv_fname = 'availability.csv'

employees = []

csv = CSV.read(csv_fname)[1..-1]
csv.each do |row|
       ary = row[0].split
       employees << Employee::Employee.new.tap do |emp|
           emp.name = ary[0]
           emp.days.each_with_index do |(key, day), index|
               day.begin = ary[index*2 + 1]
               day.end = ary[index*2 + 2]
           end
       end
end

binding.pry
