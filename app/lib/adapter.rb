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
      body: Adapter.format_abstract_body(entry.summary)
    })
    Adapter.create_keywords(abstract, ".kwd-search", agent)

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

    euro_body = remove_abstracts_header(entry.summary)
    abstract = journal.abstracts.build({
      journal: journal,
      title: entry.title,
      authors: authors.join(" "),
      url: entry.url,
      body: euro_body
    })
    Adapter.create_keywords(abstract, ".Keyword", agent)
  end

  def self.neuro_image_adapter(journal, entry)
    agent = Mechanize.new
    agent.get(entry.url)
    abstract = journal.abstracts.build({
      journal: journal,
      title: entry.title,
      authors: extract_substring_from_summary("Author(s):", "</br>", entry),
      url: entry.url,
      body: entry.summary
    })

    Adapter.create_keywords(abstract, "li.svKeywords", ".keyword", agent)
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


  def self.format_abstract_body(abstract_body)
    #to improve readability, add <br> before bolded words

    results = abstract_body.split(" ").map do |word|
      if word.include?("<b>")
        "<br><br>" + word
      else
        word
      end
    end
    results.join(" ")
  end

  def self.remove_trailing_spaces_and_symbols(string)
    symbols = [";", ",", "-"]
    letters = string.split("")
    while letters.last.blank? || symbols.include?(letters.last)
      letters.pop
    end
    letters.join("")
  end

  def self.create_keywords(abstract, css_tag, backup_css_tag=nil, agent)
    agent.page.parser.css(css_tag).each do |keyword|
      abstract.keywords.build({
        body: remove_trailing_spaces_and_symbols(keyword.text)
      })
    end
    if abstract.keywords.empty? && backup_css_tag
      agent.page.parser.css(backup_css_tag).each do |keyword|
        abstract.keywords.build({
          body: remove_trailing_spaces_and_symbols(keyword.text)
        })
      end
    end
  end

  def self.extract_substring_from_summary(start_string, end_string, entry)
    start_index = entry.summary.index(start_string)
    fragment = entry.summary.slice(start_index..-1)
    end_index = fragment.index(end_string)
    substring = fragment.slice(start_string.length...end_index)
    entry.summary = entry.summary.split(start_string+substring+end_string).join("")
    substring
  end

end
