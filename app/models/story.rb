class Story < ActiveRecord::Base
  # Validations
  validates :description, length: { maximum: 2000 }
  # --

  def author
    # Placeholder
    "John Smith"
  end
end
