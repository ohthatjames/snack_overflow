class Question < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :author, class_name: 'User'
  has_many :answers, -> { order(created_at: :asc) }
end
