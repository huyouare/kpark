namespace :script do
  desc "Send Database Query based on Hour"

  task :run, [:weekday, :hour] => :environment do |t, args|
  require 'rubygems'
  require 'json'
  require 'whenever'
  require 'mysql'
  require 'mysql2'
  require 'active_record'

  # Database connect
  @connection = ActiveRecord::Base.establish_connection(
  :adapter => "mysql",
  :host => "localhost",
  :database => "kpark",
  :username => "kpark_ruby_2013",
  :password => "froa96iaspla4ia3"
  )

  my_weekday = args[:weekday]
  my_hour = args[:hour]

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
            @result = @connection.connection.execute(query);
          end
        end
      end
    end
  end
  end

end