require "rails_helper"

describe "pages" do
  it "shows listing" do
    visit "/pages"
    expect(page).to have_content("Listing pages")
  end
end
