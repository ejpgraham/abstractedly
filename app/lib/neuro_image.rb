class NeuroImage < Adapter

  def self.build_abstract(journal, entry)
    agent = initialize_mechanize(entry)

    abstract = journal.abstracts.build({
      journal: journal,
      title: entry.title,
      authors: extract_substring_from_summary("Author(s):", "</br>", entry),
      url: entry.url,
      body: entry.summary
    })

    create_keywords(abstract, "li.svKeywords", ".keyword", agent)
  end

end
