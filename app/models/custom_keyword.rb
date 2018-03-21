class CustomKeyword < ApplicationRecord
  belongs_to :abstract, dependent: :destroy
  belongs_to :user

end
