require 'rubygems'
require 'json'
require 'whenever'

my_weekday = ARGV[0]
my_hour = ARGV[1]

puts Dir.pwd

json = JSON.parse(File.open('./script/parkingProbabilityQueries.json').read)

json['root']['weekday'].each do |weekday|
	if weekday['-name']==my_weekday
		puts weekday['-name']

		weekday['hour'].each do |hour|
			if hour['-name']==my_hour
				puts hour['-name']

				hour['query'].each do |query|
					puts query
				end
			end
		end

	end
end