
module ApplicationHelper

  def custom_keyword_belongs_to_current_user?(custom_keyword)
      custom_keyword.user_id == current_user.id
    end

    def format_abstract_body(abstract_body)
      strong_words = ["Conclusion:", "Results:", "Methods:", "Source:" ]
      results = []
      remove_extra_line_breaks(abstract_body).split(" ").each_with_index do |word, i|

        if substring_exists_in_array?(word, strong_words)
          results.push( "<br><br><strong>#{word}</strong>" )
        elsif i == 0
          results.push("<strong>Summary:</strong> #{word}")
        else
          results.push(word)
        end
      end
      results.join(" ")
    end

    def substring_exists_in_array?(substring, array)
      array.each do |ele|
        return true if ele.include?(substring) && substring.include?(":")
      end
      false
    end

    def remove_extra_line_breaks(abstract_body)
      #rss feeds include multiple breaks <br></br></br><br></br></br>
      #remove multiples for improved formatting

      results = abstract_body.split(" ").map do |ele|
        if (ele.include?("<br></br>") || ele.include?("</br><br>") || ele.include?("<br><br>")) && ele.length > 5
          new_ele = ele.gsub("<br>","").gsub("</br>","")
          "<br>" + new_ele + "<br>"

        else
          ele
        end
      end
      results.join(" ")
    end

    def randomized_background_image
    images = ["abstract1.jpg", "abstract0.jpg", "abstract2.jpg", "abstract3.jpg", "abstract4.jpg", "abstract5.jpg"]
    images[rand(images.size)]
    end

end
