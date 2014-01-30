module MotionlessAgitator
    class WeeklyDemand
        require 'csv'
        require 'chronic'

        attr_accessor :shifts

        def initialize(csv_name = nil)
            csv_name ||= "shifts.csv"
            @shifts = []
            read(csv_name)
        end

        def read(csv_name)
            csv = CSV.foreach(csv_name, :headers => true) do |csv_obj|
                @shifts << Employee::Day.new.tap do |shift|
                    date = Chronic.parse(csv_obj['date'])
                    shift.begin = Chronic.parse(csv_obj['begin'], now: date)
                    shift.end = Chronic.parse(csv_obj['end'], now: date)
                end
            end
        end
        
        def week_begins
            @shifts.min.to_date
        end

        def shifts_by_day(date)
            @shifts.select {|shift| shift.date == Chronic.parse(date, now: week_begins).to_date}
        end

        alias_method :shifts_by_date, :shifts_by_day

        def day_hours(date)
            shifts_by_day(date).inject{|sum,x| sum + x.hours}
        end

        alias_method :date_hours, :day_hours

        def week_hours
            @shifts.inject{|sum,x| sum + x.hours}
        end

    end
end

