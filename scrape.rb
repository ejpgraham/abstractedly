require "Mechanize"
require "pry-rails"

def scrape_site(url="http://jnm.snmjournals.org/rss/current.xml")
  journal_of_nuclear_medicine = Mechanize.new
  journal = journal_of_nuclear_medicine.get(url)
  page = journal_of_nuclear_medicine.page
  results = page.search('description')
  binding.pry
end

scrape_site
