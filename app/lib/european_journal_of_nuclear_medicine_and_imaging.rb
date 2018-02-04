class EuropeanJournalOfNuclearMedicineAndImaging < Adapter

  def self.build_abstract(journal, entry)

    agent = initialize_mechanize(entry)

    authors = []

    agent.parser.css(".authors__name").each do |author_html|
      authors.push(author_html.text)
    end

    euro_body = remove_abstracts_header(entry.summary)
    abstract = journal.abstracts.build({
      journal: journal,
      title: entry.title,
      authors: authors.join(" "),
      url: entry.url,
      body: euro_body
    })
    create_keywords(abstract, ".Keyword", agent)
  end

end
