module MotionlessAgitator
    
    class Renderer

        def initialize(demand, preferences)
            @demand, @preferences = demand, preferences
            @process = false
        end

        def render!
            @average = average_hours_per_employee
            @demand.sort_desending_by_daily_hours!
            @preferences.sort_ascending_by_availability
            walk_the_rooster
            @process = true
        end

        def average_hours_per_employee
            @demand.weekly_hours / @preference.number_of_employees
        end

        private
            
            def walk_the_rooster
                @demand.each do |daily_demand|
                    daily_possibles = walk_the_availability(daily_demand)
                    daily_possibles.check_for_above_average
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

            def check_for_above_average
                #go through each available person and check whether they are working above the average hours per employee this week
            end
    end
end

#######################################

    Have the walk the rooster method go through the demand (starting at the busyest day) walking through the employee list (least available first) until there is a match. Put that match in the roster class if the rostered employee hours is less than the average per employee or the preferential hours.

        If there are no matches go through and find the least above the average or preference and give it to them (If not available walk hours)

        if no matches still then go through the list until someone can do it (not working same time) remove one of their shifts and give it to them (Then do the walk witht the next guy)

            make a process that takes a shift and walks through preferences

#################
            #
For every employee (sorted by most available)
    Average = Total Hours / Employees
    if Average > Preferred
        ideal = preferred
        Total Hours -= Preferred
    else
        ideal = Average
        Total Hours -= Average

###################

For Every Available
    If (Total Hours + Shift.length) < ideal
        return employee
if employee_chosen = nil
    damage control

Damage control
    Hash of key => employees and value of (Total Hours + Shift.length) - ideal
    return hash.value_min

actually this is probably better

For Every Available
    deviation = (Total Hours + shift.length) - ideal
    return {Employee => deviation}
return employee with min deviation

######################

Go through infractions and make a hash of the deviations from ideal
    if deviations > 1 standard deviation or the deviations check = something to ensure against infinite loop
        walk through the shifts of the largest deviation
        walk shift through available employees (Sorted by deviation from ideal)
        give to min devation guy

