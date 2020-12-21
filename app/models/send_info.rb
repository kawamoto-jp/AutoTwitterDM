class SendInfo < ApplicationRecord
  validates :text, presence: true
  validates :atena, presence: true
end
