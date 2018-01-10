module ApplicationHelper

  def format_abstract_body(abstract_body)
    strong_words = ["Conclusion:", "Results:", "Methods:" ]
    results = []
    abstract_body.split(" ").each_with_index do |word, i|
      if strong_words.include?(word)
        results.push( "<br><br><strong>#{word}</strong>" )
      elsif i == 0
        results.push("<strong>Summary:</strong> #{word}")
      else
        results.push(word)
      end
    end
    results.join(" ")
  end

end
