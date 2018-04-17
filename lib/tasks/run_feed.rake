#heroku scheduled jobs/tasks

#This task will fire off the Scraper.fetch method, which
#contains all of the logic necessary to search available
#journal_feeds for new content, and add it to the application


  task :run_feed, [:journal_feed_to_be_scraped] => :environment do |t, args|
    Scraper.new
  end
