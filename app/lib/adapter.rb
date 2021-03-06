class Adapter

  def self.initialize_mechanize(entry)
    agent = Mechanize.new
    agent.keep_alive = false
    result = agent.get(entry.url)
  end

  def self.build_abstract(journal, entry)
    # agent = initialize_mechanize(entry)
    abstract_data = {}
    if entry.try(:abstract_body)
      abstract_data[:abstract_body] = entry.abstract_body
    elsif entry.summary
      abstract_data[:abstract_body] = entry.summary
    else
      abstract_data[:abstract_body] = entry.content
    end

    if entry.try(:author)
      author = entry.author
    elsif abstract_data[:abstract_body].include?("Author(s):")
      author = extract_substring_from_abstract_body("Author(s):", "</br>", abstract_data)
    end

    abstract = journal.abstracts.build({
      journal: journal,
      title: entry.title,
      url: entry.url,
      body: format_abstract_body(abstract_data[:abstract_body]),
      authors: author
    })
      abstract[:authors] = entry.author if entry.author

    # create_keywords(abstract, "Keywords", agent)
  end

  def self.remove_abstracts_header(body)
    #euro journal uses "ABSTRACT" as a header which is unnecessary and should be removed
    #this is too specific though - need a generalized method to remove headers from
    #all bodies

    results = []
    words = body.split(" ")
    body.split(" ").each do |word|
      results.push(word) unless word == "class=\"a-plus-plus\">Abstract</h3>"
    end
    results.join(" ")
  end


  def self.format_abstract_body(abstract_body)
    #removes long strings of line breaks such as "<br></br></br><br></br></br>"
    #but does not change shorter breaks such as "<br></br>"
    results = abstract_body.split(" ").map do |ele|
      if (ele.include?("<br></br>") || ele.include?("</br><br>") || ele.include?("<br><br>")) && ele.length > 10
        new_ele = ele.gsub("<br>","").gsub("</br>","")
        "<br>" + new_ele + "<br>"
      else
        ele
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
    agent.parser.css(css_tag).each do |keyword|
      abstract.keywords.build({
        body: remove_trailing_spaces_and_symbols(keyword.text)
      })
    end
    if abstract.keywords.empty? && backup_css_tag
      agent.parser.css(backup_css_tag).each do |keyword|
        abstract.keywords.build({
          body: remove_trailing_spaces_and_symbols(keyword.text)
        })
      end
    end
  end

  def self.create_keywords_from_meta_tags(abstract, meta_tag, accessor_attribute, agent)
    #Method is needed because some abstract pages hide keywords in meta html tags
    agent.parser.css(meta_tag).each do |keyword|
      abstract.keywords.build({
        body: remove_trailing_spaces_and_symbols(keyword[accessor_attribute])
      })
    end
  end

  def self.extract_substring_from_abstract_body(start_string, end_string, abstract_data)
    start_index = abstract_data[:abstract_body].index(start_string)
    fragment = abstract_data[:abstract_body].slice(start_index..-1)
    end_index = fragment.index(end_string)
    substring = fragment.slice(start_string.length...end_index)
    abstract_data[:abstract_body] = abstract_data[:abstract_body].split(start_string+substring+end_string).join("")
    substring
  end

  def self.remove_string_from_summary(string_to_be_removed, entry)
    entry.summary.gsub(string_to_be_removed, "")
  end



end
