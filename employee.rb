require 'date'

module MotionlessAgitator

    class Day
        attr_accessor :begin, :finish
        attr_reader :date, :minutes, :hours

        def begin=(time)
            @begin = time
            @date = @begin.to_date
        end

        def finish=(time)
            @end =time
            calculate_minutes
            calculate_hours
        end

        private

            def calculate_minutes
                unless @begin.nil? 
                    @minutes = (@end - @begin)/60
                else
                    @minutes = 0
                end
            end

            def calculate_hours
                @hours = @minutes/60
            end


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
