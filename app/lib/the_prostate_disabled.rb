class TheProstate < Adapter

  def self.build_abstract(journal, entry)
    agent = initialize_mechanize(entry)

    abstract = journal.abstracts.build({
      journal: journal,
      title: entry.title,
      authors: entry.author,
      url: entry.url,
      body: format_abstract_body(entry.summary)
    })
    create_keywords_from_meta_tags(abstract, 'meta[name="citation_keywords"]', :content, agent)
  end
end
