class Adapter

  def self.journal_of_nuclear_medicine_adapter(journal, entry)
    #rss feed does not list keywords. use url to locate keywords.
    agent = Mechanize.new
    agent.get(entry.url)
    abstract = journal.abstracts.build({
      journal: journal,
      title: entry.title,
      authors: entry.author,
      url: entry.url,
      body: entry.summary
    })

    agent.page.parser.css(".kwd-search").each do |keyword|
      abstract.keywords.build({
        body: keyword.text
      })
    end

  end

  def self.european_journal_adapter(journal, entry)
    #this journal does not list authors in the rss feed
    #use url to locate author tags
    #does not list keywords. use url to locate keywords
    agent = Mechanize.new
    agent.get(entry.url)
    authors = []
    agent.page.parser.css(".authors__name").each do |author_html|
      authors.push(author_html.text)
    end


    euro_body = Adapter.remove_abstracts_header(entry.summary)
    abstract = journal.abstracts.build({
      journal: journal,
      title: entry.title,
      authors: authors.join(", "),
      url: entry.url,
      body: euro_body
    })

    agent.page.parser.css(".Keyword").each do |keyword|
      abstract.keywords.build({
        body: keyword.text
      })
    end

  end

  def self.neuro_image_adapter(journal, entry)
    abstract = journal.abstracts.build({
      journal: journal,
      title: entry.title,
      authors: "empty",
      url: entry.url,
      body: entry.summary
    })
  end

  private

  def self.remove_abstracts_header(body)

    #euro journal uses "ABSTRACT" as a header which is
    #unnecessary and must be removed
    results = []
    words = body.split(" ")
    body.split(" ").each do |word|
      results.push(word) unless word == "class=\"a-plus-plus\">Abstract</h3>"
    end
    results.join(" ")
  end

end
