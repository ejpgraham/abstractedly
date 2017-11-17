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

journals = Journal.create([
  {title: "Journal of Nuclear Medicine" , url: "http://jnm.snmjournals.org/" , subscribed: true, date: '%2017-%11-%1' , volume: 45 , issue_number: 1}
])

abstracts = Abstract.create([
  {title: JournalData.titles[0], authors: JournalData.authors[0], body: JournalData.bodies[0], images: "", url: "www.abstract.com", visible: true, journal: journals.sample},
  {title: JournalData.titles[1], authors: JournalData.authors[1], body: JournalData.bodies[1], images: "", url: "www.abstract.com", visible: true, journal: journals.sample},
  {title: JournalData.titles[2], authors: JournalData.authors[2], body: JournalData.bodies[2], images: "", url: "www.abstract.com", visible: true, journal: journals.sample},
  {title: JournalData.titles[3], authors: JournalData.authors[3], body: JournalData.bodies[3], images: "", url: "www.abstract.com", visible: true, journal: journals.sample},
  {title: JournalData.titles[4], authors: JournalData.authors[4], body: JournalData.bodies[4], images: "", url: "www.abstract.com", visible: true, journal: journals.sample},
])

puts "Seed finished."
puts "#{Journal.count} journals created"
puts "#{Abstract.count} abstracts created"
