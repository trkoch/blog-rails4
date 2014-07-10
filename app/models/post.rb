class Post < ActiveRecord::Base
  default_scope { order("created_at DESC") }

  def excerpt
    body[0...100]
  end
end
