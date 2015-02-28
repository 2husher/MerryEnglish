require 'spec_helper'

feature 'Viewing Translate Me' do
  given!(:dictionary) { FactoryGirl.create(:dictionary) }

  given!(:lesson_one) { FactoryGirl.create(:lesson, number: 1) }
  given!(:lesson_two) { FactoryGirl.create(:lesson, number: 2) }

  given!(:a) { FactoryGirl.create(:letter, name: 'A', dictionary: dictionary) }
  given!(:b) { FactoryGirl.create(:letter, name: 'B', dictionary: dictionary) }

  given!(:noun) { FactoryGirl.create(:part_of_speech, name: "noun", acronym: "N") }
  given!(:adj) { FactoryGirl.create(:part_of_speech, name: "adjective", acronym: "ADJ") }

  given!(:first_word) { FactoryGirl.create(:entity, word: "bare", translation: "босые",
                                sentence: "He likes to walk around in his bare feet.",
                                letter: b, lesson: lesson_two, part_of_speech: adj) }
  given!(:second_word) { FactoryGirl.create(:entity, word: "ability", translation: "способность",
                                sentence: "His swimming abilities let him cross the entire lake.",
                                letter: a, lesson: lesson_one, part_of_speech: noun) }

  scenario "Translate Me All path" do
    visit translate_me_all_path

    expect(page).to have_title("MerryEnglish")

    expect(page).to have_content("Dictionary")
    expect(page).to have_content("Lessons")
    expect(page).to have_content("Translate Me")
    expect(page).to have_css("div.container")
    expect(page).to have_css("h1")

    expect(page).to have_content("Translate Me")
    expect(page).to have_link("All Games")

    expect(page).to have_content("2015 by Alex Izotov (izotovalexander@gmail.com)")
  end

  scenario "Translate Me path" do
    visit translate_me_path(lesson_one.number)

    expect(page).to have_content("Game for Lesson 1")
    expect(page).to have_content(second_word.word)
    expect(page).to have_content("Games: 1 2")
  end

  scenario "Follow Translate Me" do
    visit translate_me_all_path

    first(:link, "Translate Me Game").click
    expect(page.current_url).to eql(translate_me_url(lesson_one.number))
  end

  scenario "Follow Game on Translate Me" do
    visit translate_me_path(lesson_one.number)

    click_link "Game"
    expect(page.current_url).to eql(translate_me_url(lesson_one.number))
  end

  scenario "Follow Lesson 1 on Translate Me" do
    visit translate_me_path(lesson_one.number)

    click_link "Lesson 1"
    expect(page.current_url).to eql(lesson_url(lesson_one.number))
  end

  scenario "Follow All Games on Translate Me" do
    visit translate_me_path(lesson_one.number)

    click_link "All Games"
    expect(page.current_url).to eql(translate_me_all_url)
  end
end