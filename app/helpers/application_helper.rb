module ApplicationHelper

  def custom_keyword_belongs_to_current_user?(custom_keyword)
    custom_keyword.user_id == current_user.id
  end

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

  def randomized_background_image
  images = ["abstract1.jpg", "abstract0.jpg", "abstract2.jpg", "abstract3.jpg", "abstract4.jpg", "abstract5.jpg"]
  images[rand(images.size)]
  end

end
