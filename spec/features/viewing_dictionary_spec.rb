require 'spec_helper'

feature 'Viewing Dictionary' do
  before :each do
    d = FactoryGirl.create(:dictionary)
    ('A'..'Z').each do |l|
      FactoryGirl.create(:letter, name: l, dictionary: d)
    end
    FactoryGirl.create(:part_of_speech, name: "noun", acronym: "N")
    FactoryGirl.create(:part_of_speech, name: "adjective", acronym: "ADJ")
    FactoryGirl.create(:part_of_speech, name: "verb", acronym: "V")
    FactoryGirl.create(:part_of_speech, name: "adverb", acronym: "ADV")
    FactoryGirl.create(:part_of_speech, name: "conjunction", acronym: "CONJ")
    FactoryGirl.create(:part_of_speech, name: "preposition", acronym: "PREP")
  end

  scenario "Index of words" do
    visit '/dictionary/all'
    expect(page).to have_title("MerryEnglish")

    expect(page).to have_content("Dictionary")
    expect(page).to have_content("Lessons")
    expect(page).to have_content("Translate Me")

    expect(page).to have_content("Dictionary")
    expect(page).to have_content("All Letters A B C D E F G H I J K L M N O P Q R S T U V W X Y Z ")
    expect(page).to have_content("noun | adjective | verb | adverb | conjunction | preposition |")
    expect(page).to have_content("Index")

    expect(page).to have_content("2015 by Alex Izotov (izotovalexander@gmail.com)")
  end
end