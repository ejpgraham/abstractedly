module JournalFeedsHelper
  def scrape_site(url="http://jnm.snmjournals.org/rss/current.xml")
    journal_of_nuclear_medicine = Mechanize.new
    journal_of_nuclear_medicine.get(url)
  end
end
