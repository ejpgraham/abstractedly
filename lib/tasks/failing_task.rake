task :failing_task => :environment do
  puts "Failing task in environment #{Rails.env}..."
  FAIL!
end
