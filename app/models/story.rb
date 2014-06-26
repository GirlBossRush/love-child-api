class Story < ActiveRecord::Base
  # Validations
  validates :description, length: { maximum: 2000 }
  # --

  default_scope { order("created_at DESC") }
  def author
    # Placeholder
    "John Smith"
  end
end
