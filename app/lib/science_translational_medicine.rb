class ScienceTranslationalMedicine < Adapter

  def self.build_abstract(journal, entry)
    agent = Mechanize.new
    abstract = journal.abstracts.build({
      journal: journal,
      title: entry.title,
      authors: entry.author,
      url: entry.url,
      body: entry.summary
    })
  end

end
