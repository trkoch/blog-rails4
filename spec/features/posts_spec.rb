require "rails_helper"

describe "posts" do
  after :each do
    Post.delete_all
  end

  it "shows listing" do
    Post.create!(title: "Some title", body: "Some body")
    Post.create!(title: "Another title", body: "Another body")
    visit "/blog/posts"
    expect(page).to have_content("Listing posts")
    within "table.posts" do
      expect(page).to have_css("tbody tr", count: 2)
      expect(page).to have_css("tbody td", text: "Some title")
      expect(page).to have_css("tbody td", text: "Some body")
    end
  end

  it "shows most recent first" do
    Post.create!(title: "Old", created_at: Date.new(2010))
    Post.create!(title: "Most Recent")
    visit "/blog/posts"
    posts = page.all("table.posts tbody td:first-child")
    expect(posts.first).to have_content("Most Recent")
  end
end
