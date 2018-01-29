class JournalOfBiochemistry < Adapter

  def self.build_abstract(journal, entry)
    # this journal does not look for keywords because mechanize
    # can't visit its domain without throwing an error 
    # agent = initialize_mechanize(entry)

    abstract = journal.abstracts.build({
      journal: journal,
      title: entry.title,
      authors: entry.author,
      url: entry.url,
      body: format_abstract_body(entry.summary)
    })

    # create_keywords(abstract, "kwd-group", agent)
  end

end
