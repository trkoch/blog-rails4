class Post < ActiveRecord::Base
  def self.all
    some_method
    super
  end

  def self.some_method
    fail if some_str.present?
  end

  def self.some_str
    "Some str"
  end
end
