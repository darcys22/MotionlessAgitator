module MotionlessAgitator
    
    class Renderer

        def initialize(demand, preferences)
            @demand, @preferences = demand, preferences
            @process = false
            @schedule = Schedule.new 
        end

        def render!
            @demand.sort_desending_by_daily_hours!  # Need to define these messages
            @preferences.sort_ascending_by_availability
            walk_the_rooster
            @process = true
        end

        private
            
            def walk_the_rooster
                ideal = calculate_ideal
                @demand.each do |daily_demand|     
                    daily_possibles = walk_the_availability(daily_demand)
                    possibles_deviation = deviation(daily_possibles, ideal, day)
                    @schedule.add(possibles_deviation.values.min_by(&:last))

                end
            end

            def walk_the_availability(day)
                possibles = @preferences.select do |pool, employee_availability|    
                    if (day.begin < employee_availability.begin) && (day.end > employee_availability.finish)
                        pool
                    end
                end
                if possibles.length < 1
                    raise NoAvailabilityError
                else
                    possibles
                end
            end

            def deviation(possibles, employee_ideals, day)
                possibles.inject(0) |deviation, employee| do
                    deviation[employee] = (@schedule.hours[:employee] + daily_demand.shift_length) - employee_ideals[:employee]
                end
            end


            def calculate_ideal
                week_hourly_demand = @demand.weekly_hours
                @preferences.employees_by_least_available.inject(0) |ideal, (employee, count)| do
                    average = week_hourly_demand / (@preference.number_of_employees - count)
                    if average > employee.desired_hours
                        ideal[employee] = employee.desired_hours
                        week_hourly_demand -= employee.desired_hours
                    else
                        idea[employee] = average
                        week_hourly_demand -= average
                    end
                end
            end
    end
end


#Go through infractions and make a hash of the deviations from ideal
    #if deviations > 1 standard deviation or the deviations check = something to ensure against infinite loop
        #walk through the shifts of the largest deviation
        #walk shift through available employees (Sorted by deviation from ideal)
        #give to min devation guy

