require 'date'

module Employee

    class Day
        attr_accessor :date, :begin, :end
    end

    class EmployeeWeekBase
        attr_accessor :name, :days

        def initialize
            @days = Hash[
                Monday: Day.new,
                Tuesday: Day.new,
                Wednesday: Day.new,
                Thursday: Day.new,
                Friday: Day.new,
                Saturday: Day.new,
                Sunday: Day.new ]
        end
    end
    
    class EmployeePreference < EmployeeWeekBase
        attr_accessor :desired_hours
    end
    #sean.days.has_key?(Date.today.strftime("%A").to_sym)
    
    class EmployeeRoster < EmployeeWeekBase
        attr_accessor :total_hours 
    end

end
