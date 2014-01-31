module MotionlessAgitator
    
    class Renderer

        def initialize(preferences, demand)
            @demand, @preferences = demand, preferences
            @processed = false
            @schedule = Schedule.new 
        end

        def render!
            @demand.sort_by_busiest
            @preferences.sort_by_least_available
            walk_the_rooster
            @processed = true
        end

        private
            
            def walk_the_rooster
                ideal = calculate_ideal
                @demand.each do |daily_demand|     
                    daily_possibles = seach_for_available(daily_demand)
                    possibles_deviation = deviation(daily_possibles, ideal, daily_demand)
                    @schedule.add(min_dev(possibles_deviation), daily_demand)
                end
            end

            def min_dev_name(dev_list)
                dev_list.values.min_by(&:last).key
            end

            def search_for_available(day)
                possibles = @preferences.select do |employee_availability|    
                    (day.begin < employee_availability.begin) && (day.end > employee_availability.finish)
                end
                if possibles.length < 1
                    raise NoAvailabilityError
                else
                    possibles
                end
            end

            def deviation(possibles, employee_ideals, day)
                possibles.inject(0) do |deviation, employee| 
                    deviation[employee] = (@schedule.hours(:employee) + day.shift_length) - employee_ideals[:employee]
                end
            end


            def calculate_ideal
                week_hourly_demand = @demand.week_hours
                @preferences.employees_by_least_available.inject(0) do |ideal, (employee, count)|
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

