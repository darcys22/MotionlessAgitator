module MotionelessAgitator
    class EmployeeAvailability
        require 'csv'
        require 'chronic'

        IMPORTANT = Chronic.parse("22nd November 1990")
        
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
                           day.begin = Chronic.parse(ary[index*2 + 1], now: IMPORTANT)
                           day.end = Chronic.parse(ary[index*2 + 2], now: IMPORTANT)
                       end
                   end
            end
            @employees
        end

        def number_of_employees
            @employees.length
        end
    end
end

