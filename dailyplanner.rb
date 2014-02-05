module MotionlessAgitator
    class DailyPlanner
        attr_reader :daily_schedule

        def initialize(daily_options)
            @daily_options = daily_options
        end

        def plan!
            shifts_by_options_count = count_shift_pool
            shifts_by_options_count.sort_by! { |shift, count| count}
            shifts_by_options_count.each do |shift, count|
                employee = find_least_available_employee(shift)
                add_shift(shift, employee)
            end
            @daily_schedule
        end

        def find_least_available_employee(shift)
            shift_count = count_employee_occurance
            shift_count.sort_by {|employee, count| count}
            shift_count.each do |employee, count|
                return employee if @daily_options.includes?([shift,employee])
            end
            nil
        end

        def count_shift_pool
            @daily_options.inject({}) do |count, option|
                if count.include?(option[0])
                    count[option[0]] += 1
                else
                    count[option[0]] = 1
                end
                count
            end
        end
        
        def add_shift(shift, employee)
            unless @daily_schedule.include?(shift)
                @daily_schedule[shift] = employee
                remove_from_options(shift)
            end
        end

        def count_employee_occurance
            @daily_options.inject({}) do |count, option|
                if count.include?(option[1])
                    count[option[1]] += 1
                else
                    count[option[1]] = 1
                end
                count
            end
        end

        def remove_from_options(shift)
            @daily_options.delete_if { |option| option[0] == shift }
        end
    end
end


 
