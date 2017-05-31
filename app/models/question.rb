class Question < ApplicationRecord
  belongs_to :user, dependent: :destroy
	has_many :answers
  validates :title, :body, presence: true
end
