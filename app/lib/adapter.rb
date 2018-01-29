class Adapter

  def self.initialize_mechanize(entry)
    agent = Mechanize.new
    agent.keep_alive = false
    result = agent.get(entry.url)
  end

  def self.remove_abstracts_header(body)

    #euro journal uses "ABSTRACT" as a header which is unnecessary and should be removed
    results = []
    words = body.split(" ")
    body.split(" ").each do |word|
      results.push(word) unless word == "class=\"a-plus-plus\">Abstract</h3>"
    end
    results.join(" ")
  end


  def self.format_abstract_body(abstract_body)

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

  def self.extract_substring_from_summary(start_string, end_string, entry)
    start_index = entry.summary.index(start_string)
    fragment = entry.summary.slice(start_index..-1)
    end_index = fragment.index(end_string)
    substring = fragment.slice(start_string.length...end_index)
    entry.summary = entry.summary.split(start_string+substring+end_string).join("")
    substring
  end

  def self.remove_string_from_summary(string_to_be_removed, entry)
    entry.summary.gsub(string_to_be_removed, "")
  end

end
