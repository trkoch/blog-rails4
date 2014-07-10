class Post < ActiveRecord::Base
  default_scope { order("created_at DESC") }

  def excerpt
    return body if body.length <= 100
    body[0...100] + "…"
  end
end
