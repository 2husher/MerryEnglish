require 'spec_helper'

feature 'Viewing Lessons' do
  before :each do
  end

  scenario "All Lessons" do
    visit '/lessons/all'
    expect(page).to have_title("MerryEnglish")

    expect(page).to have_content("Dictionary")
    expect(page).to have_content("Lessons")
    expect(page).to have_content("Translate Me")

    expect(page).to have_content("Lessons")
    expect(page).to have_content("All Lessons")

    expect(page).to have_content("2015 by Alex Izotov (izotovalexander@gmail.com)")
  end
end