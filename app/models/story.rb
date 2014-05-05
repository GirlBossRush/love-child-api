class Story < ActiveRecord::Base
  # Validations
  validates :body, :title, presence: true
  validates :description, length: { maximum: 2000 }

  validates :body, length: { minimum: 5 }
  # --
end
