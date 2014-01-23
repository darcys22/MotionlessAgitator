require 'pry'
require 'date'

module Employee

    class Day
        attr_accessor :day, :begin, :end
    end

    class Employee
        attr_accessor :name, :days, :shifts, :hours

        def initialize
            @days, @shifts = Hash[
                Monday: Day.new,
                Tuesday: Day.new,
                Wednesday: Day.new,
                Thursday: Day.new,
                Friday: Day.new,
                Saturday: Day.new,
                Sunday: Day.new ]
        end
    end

    #sean = Employee.new
    #sean.days.has_key?(Date.today.strftime("%A").to_sym)
    #binding.pry

end
