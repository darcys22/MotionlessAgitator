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
            end
    end
end

#######################################

    Have the walk the rooster method go through the demand (starting at the busyest day) walking through the employee list (least available first) until there is a match. Put that match in the roster class if the rostered employee hours is less than the average per employee or the preferential hours.

        If there are no matches go through and find the least above the average or preference and give it to them (If not available walk hours)

        if no matches still then go through the list until someone can do it (not working same time) remove one of their shifts and give it to them (Then do the walk witht the next guy)

            make a process that takes a shift and walks through preferences
