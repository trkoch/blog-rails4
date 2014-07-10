require "rails_helper"

describe Post do
  let(:post) { Post.new }

  describe "excerpt" do
    it "does not truncate when less or equal 100 characters" do
      post.body = "Some body"
      expect(post.excerpt).to eq(post.body)
    end

    it "truncates body to first 100 characters plus ellipsis" do
      post.body = "X" * 100 + "Z"
      expect(post.excerpt.length).to eq(100 + 1)
      expect(post.excerpt).not_to include("Z")
    end

    it "appends ellipsis when truncating" do
      post.body = "X" * 200
      expect(post.excerpt).to match(/X…$/)
    end

    it "ignores blank input" do
      post.body = nil
      expect(post.excerpt).to eq(post.body)
      post.body = ""
      expect(post.excerpt).to eq(post.body)
    end
  end
end
