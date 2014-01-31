module MotionlessAgitator

    class Schedule
        def add(name, day)
            @schedule[name] = day
        end

        def return_by_day(day)
            @schedule.select do |element| 
                DAYNAMES[element.value.begin.wday]  == day
            end
        end

        def return_by_date(date)
            @schedule.select do |element|
                element.value.begin.to_date == date
            end 
        end

        def week_start
            @schedule.values.min.to_date
        end

        def by_employee(employee)
            @schedule.inject(0) do |hours, (key, value) |
                hours += value.hours if key == employee
            end
        end
    end
end
