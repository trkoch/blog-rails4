class Post < ActiveRecord::Base
  default_scope { order("created_at DESC") }

  def excerpt(count=100)
    return body if body.blank? or body.length <= count
    body[0...count] + "…"
  end
end
