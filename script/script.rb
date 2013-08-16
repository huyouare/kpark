require 'rubygems'
require 'json'
require 'net/http'

# $stdout = File.new('console.out', 'w')

puts Dir.pwd

t = Time.now
wday = t.wday

days = { 0 => "Sunday" , 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5 => "Friday", 6 => "Saturday" }

puts "This hour: " + t.hour.to_s
puts "This day: " + days[t.wday]

my_hour = t.hour.to_s
my_weekday = days[t.wday]

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
				web_request.gsub!(' ', '%20')
				puts web_request
				uri = URI.parse(URI.encode(web_request.strip))
				res = Net::HTTP.get(uri)
				puts res
			end
		end

	end
end