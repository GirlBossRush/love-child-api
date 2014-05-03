class Story < ActiveRecord::Base

  def created_at_formatted
    self.created_at.iso8601
  end
end
