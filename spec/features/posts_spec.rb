require "rails_helper"

describe "posts" do
  after :each do
    Post.delete_all
  end

  it "shows excerpt of post when appropriate" do
    str =  "A very long body," + " some words, " * 10 + " here we end"
    post = Post.create!(title: "A title", body: str)

    visit "/blog/posts"
    body = page.all("table.posts td.body").first
    expect(body).to have_no_content("here we end")

    visit "/blog/posts/#{post.id}"
    body = page.find(".body")
    expect(body).to have_content(str)
  end

  it "creates post" do
    visit "/blog/posts"
    click_link "New Post"
    fill_in "Title", with: "Some title"
    fill_in "Body", with: "Some body"
    click_button "Create Post"
    expect(page).to have_content("Post was successfully created.")
  end

  it "does not allow to create invalid post" do
    visit "/blog/posts"
    click_link "New Post"
    fill_in "Title", with: ""
    fill_in "Body", with: "Some body"
    click_button "Create Post"
    expect(page).to have_content("Title can't be blank")
  end

  describe "index" do
    it "shows listing of posts" do
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

    it "shows most recent post first" do
      Post.create!(title: "Old", created_at: Date.new(2010))
      Post.create!(title: "Most Recent")
      visit "/blog/posts"
      posts = page.all("table.posts tbody td:first-child")
      expect(posts.first).to have_content("Most Recent")
    end
  end
end
