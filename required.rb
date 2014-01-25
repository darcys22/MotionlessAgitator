module RequiredWork
    class WeeklyDemand
        require 'csv'
        attr_accessor :shifts

        def initializei(csv_name = nil)
            csv_name ||= "shifts.csv"
            @shifts = []
            read(csv_name)

        end

        def read(csv_name)
            csv = CSV.foreach(csv_name, :headers => true) do |csv_obj|
                @shifts << Employee::Day.new.tap do |shift|
                    shift.date = csv_obj['date']
                    shift.begin = csv_obj['begin']
                    shift.end = csv_obj['end']
                end
            end
            binding.pry
        end

        def day
        end

        def date
        end

        def day_total
        end

        def date_total
        end

        def week_begin
        end

    end
end

