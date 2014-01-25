require 'date'

module Employee

    class Day
        attr_accessor :date, :begin, :end
    end

    class EmployeePreference
        attr_accessor :name, :days, :hours

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
    #sean.days.has_key?(Date.today.strftime("%A").to_sym)

end
