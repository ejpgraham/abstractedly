module ScrapeHelper
  def scrape_site(url="http://jnm.snmjournals.org/rss/current.xml")
    journal_of_nuclear_medicine = Mechanize.new
    journal = journal_of_nuclear_medicine.get(url)
    page = journal_of_nuclear_medicine.page
    binding.pry
  end
end
