class User < ActiveRecord::Base
  private_attributes = [:password_digest, :role]

  # Relations
  has_many :stories
  # ----

  def to_json(options = {})
    options[:except] ||= private_attributes

    super(options)
  end


  def name
    read_attribute(:name) || "Anonymous"
  end
end
