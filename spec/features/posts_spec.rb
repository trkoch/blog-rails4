require "rails_helper"

describe "posts" do
  it "shows listing" do
    Post.create!(title: "Some title", body: "Some body")
    Post.create!(title: "Another title", body: "Another body")
    visit "/blog/posts"
    expect(page).to have_content("Listing posts")
    expect(page).to have_css("tbody tr", count: 2)
    expect(page).to have_css("tbody td", text: "Some title")
    expect(page).to have_css("tbody td", text: "Some body")
  end
end
