class Abstract < ActiveRecord::Base
  belongs_to :journal
  has_many :keywords
  has_many :custom_keywords
end
