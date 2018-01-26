class ElifeSciences < Adapter

  def self.build_abstract(journal, entry)

    abstract = journal.abstracts.build({
      journal: journal,
      title: entry.title,
      authors: entry.author,
      url: entry.url,
      body: format_abstract_body(entry.content)
    })

  end

end
