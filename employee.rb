require 'date'

module MotionlessAgitator

    class Day
        attr_accessor :start, :finish
        attr_reader :date, :minutes, :hours

        def start=(time)
            @start = time
            @date = @start.to_date
        end

        def finish=(time)
            @finish =time
            calculate_minutes
            calculate_hours
        end

        private

            def calculate_minutes
                unless @start.nil? 
                    @minutes = (@finish - @start)/60
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
        
        def total_hours 
           @days.inject(0) do |sum, (key, value)|
               sum += value.hours
           end
        end     
    end
    
    class EmployeePreference < EmployeeWeekBase
        attr_accessor :desired_hours

        def available?(day)
            (time_on_date(day.start) < self.available_start(day)) && (time_on_date(day.finish) > self.available_finish(day))
        end 

        def available_start(date)
            time_on_date(day_from_date(date).start)
        end

        def available_end(date)
            time_on_date(day_from_date(date).finish)
        end

        private 
            
            def day_from_date(date)
                @days[::Date::DAYNAMES[date.start.wday].to_sym]
            end

            def time_on_date(date) # Wow wtf
                Time.at(date.hour * 60 * 60 + date.min * 60)
            end
    end
end
