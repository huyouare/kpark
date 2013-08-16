require 'rubygems'
require 'json'
require 'net/http'

t = Time.now
wday = t.wday

days = { 0 => "Sunday" , 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5 => "Friday", 6 => "Saturday" }

puts t.hour
puts days[t.wday]

my_hour = "10"
my_weekday = "Monday"

puts Dir.pwd

json = JSON.parse(File.open('./script/parkingProbabilityQueries.json').read)

json['root']['weekday'].each do |weekday|
	if weekday['-name']==my_weekday
		puts weekday['-name']

		weekday['hour'].each do |hour|
			if hour['-name']==my_hour
				puts hour['-name']

				# hour['query'].each do |query|
				# 	print query
				# end
				query = hour['query'].first
				web_request = 'http://davami.com/kpark/runquery.php?query=' + query
				puts web_request
				uri = URI(web_request)
				Net::HTTP.get(uri)

			end
		end

	end
end