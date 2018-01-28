# This file should contain all the record creation needed to seed the JournalDatabase with its default values.
# The JournalData can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
require 'journal_data'




journal_feed_parameters = ([
  # {title: "Journal of Nuclear Medicine" , url: "http://jnm.snmjournals.org/rss/current.xml", cover_image_url: "http://jnm.snmjournals.org/content/vol58/issue12/home_cover.gif" },
  # {title: "European Journal of Nuclear Medicine and Imaging", url: "https://link.springer.com/search.rss?facet-content-type=Article&facet-journal-id=259&channel-name=European+Journal+of+Nuclear+Medicine+and+Molecular+Imaging", cover_image_url: ""},
  # {title: "NeuroImage", url: "http://rss.sciencedirect.com/publication/science/10538119", cover_image_url: "https://ars.els-cdn.com/content/image/S10538119.gif" },
  # {title: "Science Translational Medicine", url: "http://stm.sciencemag.org/rss/current.xml", cover_image_url: "http://stm.sciencemag.org/content/scitransmed/10/423/F1.medium.gif" },
  # {title: "Nuclear Medicine and Biology", url: "http://rss.sciencedirect.com/publication/science/09698051", cover_image_url: "https://ars.els-cdn.com/content/image/X09698051.jpg"},
  # {title: "Cell", url: "http://www.cell.com/cell/current.rss", cover_image_url: "http://www.cell.com/cms/attachment/2118937809/2086969257/cov150h.gif"},
  # {title: "Science", url: "http://science.sciencemag.org/rss/express.xml", cover_image_url: ""},
  # {title: "Biochimica et Biophysica Acta", url: "http://rss.sciencedirect.com/publication/science/03044165", cover_image_url: ""},
  # {title: "Journal of Biochemistry", url: "https://academic.oup.com/rss/site_5303/3169.xml"},
  {title: "E Life Sciences", url: "https://medium.com/feed/@eLife"},
  # {title: "The Prostate", url: "http://onlinelibrary.wiley.com/rss/journal/10.1002/(ISSN)1097-0045"}
])

journal_feed_parameters.each do |params|
  JournalFeed.find_or_create_by(params)
end

# journals = Journal.create!([
#   {title: "Journal of Nuclear Medicine", url: "http://jnm.snmjournals.org/", date: '%2017-%11-%1' , volume: 45 , issue_number: 1, journal_feed: journal_feeds[0]},
#   ])

# abstracts =
#   15.times do
#     Abstract.create!(
#         title: JournalData.title,
#         body: JournalData.body,
#         authors: JournalData.author,
#         images: "",
#         url: "http://jnm.snmjournals.org/",
#         visible: true,
#         journal: journals.sample
#       )
#   end
#
#   Abstract.all.each do |abstract|
#     rand(4..8).times do
#       Keyword.create!(
#         body: JournalData.keyword,
#         abstract: abstract
#       )
#     end
#   end

 if User.all.empty?
  User.create!(
  email: "ejpgraham@gmail.com",
  password: "password",
  )
end
#
# subscriptions = Subscription.create!(
#   user: admin,
#   journal_feed: journal_feeds[0]
# )




puts "Seed finished."
puts "#{JournalFeed.count} journal feeds created"
puts "#{Journal.count} journals created"
puts "#{Abstract.count} abstracts created"
puts "#{Keyword.count} keywords created"
