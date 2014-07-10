require "rails_helper"

describe Post do
  let(:post) { Post.new }

  describe "excerpt" do
    it "truncates body to first 100 characters" do
      post.body = "X" * 100 + "Z"
      expect(post.excerpt.length).to eq(100)
      expect(post.excerpt).not_to include("Z")
    end
  end
end
