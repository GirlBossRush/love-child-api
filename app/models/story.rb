class Story < ActiveRecord::Base
  # Validations
  validates :description, length: { maximum: 2000 }
  # --

  def title=(title)
    write_attribute :title, Sanitize.fragment(title)
  end

  def description=(description)
    write_attribute :description, Sanitize.fragment(description)
  end

  def body=(body)
    write_attribute :body, Sanitize.fragment(body, Sanitize::Config::BASIC)
  end

  def author
    # Placeholder
    "Anonymous"
  end
end
