# This file should contain all the record creation needed to seed the JournalDatabase with its default values.
# The JournalData can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
require 'journal_data'
# Journal attributes:

# t.string :title
# t.string :url
# t.boolean :subscribed
# t.date :date
# t.integer :volume
# t.integer :issue_number

# Abstract attributes

# t.text :title
# t.text :authors
# t.text :body
# t.string :images
# t.string :url
# t.boolean :visible
# t.references :journal, index: true, foreign_key: true

journals = Journal.create!([
  {title: "Journal of Nuclear Medicine" , url: "http://jnm.snmjournals.org/" , subscribed: true, date: '%2017-%11-%1' , volume: 45 , issue_number: 1}
])

abstracts =
  10.times do
    Abstract.create!(
        title: JournalData.title,
        body: JournalData.body,
        authors: JournalData.author,
        images: "",
        url: "http://jnm.snmjournals.org/",
        visible: true,
        journal: journals[0]
      )
  end

  Abstract.all.each do |abstract|
    rand(4..8).times do
      Keyword.create!(
        body: JournalData.keyword,
        abstract: abstract
      )
    end
  end


puts "Seed finished."
puts "#{Journal.count} journals created"
puts "#{Abstract.count} abstracts created"
puts "#{Keyword.count} keywords created"
