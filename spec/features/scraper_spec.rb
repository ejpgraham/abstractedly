require 'rails_helper'
require_relative 'journal_examples'

describe Scraper do
    test_journal = JournalFeed.all.last
  it 'Runs the fetch process on a single journal feed if an argument is provided' do
    new_scraper_instance = Scraper.new(test_journal)
    expect(new_scraper_instance.journal_feeds).to eq([test_journal])
  end

  it 'Runs the fetch process on all journal feeds if no argument is provided' do
    new_scraper_instance = Scraper.new
    expect(new_scraper_instance.journal_feeds).to eq(JournalFeed.all)
  end

  


end
