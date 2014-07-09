require "rails_helper"

describe "posts" do
  it "shows listing" do
    visit "/blog/posts"
    expect(page).to have_content("Listing posts")
  end
end
