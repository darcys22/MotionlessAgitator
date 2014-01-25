module Availability
    class EmployeeAvailability
        require 'csv'
        attr_accessor :employees

        def initialize(csv_name = nil)
            csv_name ||= "availability.csv"
            @employees = []
            read(csv_name)
        end

        def read(csv_name)
            csv = CSV.read(csv_name)[1..-1]
            csv.each do |row|
                   ary = row[0].split
                   @employees << Employee::EmployeePreference.new.tap do |emp|
                       emp.name = ary[0]
                       emp.days.each_with_index do |(key, day), index|
                           day.begin = ary[index*2 + 1]
                           day.end = ary[index*2 + 2]
                       end
                   end
            end
            @employees
        end
    end
end

