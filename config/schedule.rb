# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, "./cron_log.log"

weekdays = [:Monday, :Tuesday, :Wednesday, :Thursday, :Friday]
hours = [8, 10, 12, 14, 16, 18, 20]

weekdays.each do |weekday|
	hours.each do |hour|
		if hour>=12
			suffix="pm"
		else 
			suffix="am"
		end
		time = hour.to_s + suffix
    rake_cmd = "script:run[#{weekday.to_s},#{hour.to_s}]"
		every weekday, :at => time do
			rake rake_cmd
		end
	end
end


	# every :monday, :at => '12pm' do # Use any day of the week or :weekend, :weekday
	#   runner "./script/script.rb" 
	# end