class User < ActiveRecord::Base
  def name
    read_attribute(:name) || "Anonymous"
  end
end
