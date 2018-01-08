class Keyword < ActiveRecord::Base
  belongs_to :abstract

  def self.search(search)
    where("body LIKE ?", "%#{search}%")
  end
end
