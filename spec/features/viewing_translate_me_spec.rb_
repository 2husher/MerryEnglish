require 'spec_helper'

feature 'Viewing Translate Me' do
  subject { page }

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

  feature "Translate Me All path" do
    before do
      visit translate_me_all_path
    end

    scenario { should have_title("MerryEnglish") }

    scenario { should have_content("Dictionary") }
    scenario { should have_content("Lessons") }
    scenario { should have_content("Translate Me") }
    scenario { should have_css("div.container") }
    scenario { should have_css("h1") }

    scenario { should have_content("Translate Me") }
    scenario { should have_link("All Games") }

    scenario { should have_content("2015 by Alex Izotov (izotovalexander@gmail.com)") }
  end

  feature "Translate Me path" do
    before do
      visit translate_me_path(lesson_one.number)
    end

    scenario { should have_content("Game for Lesson 1") }
    scenario { should have_content(second_word.word) }
    scenario { should have_content("Games: 1 2") }
  end

  feature "Follow Translate Me" do
    before do
      visit translate_me_all_path
      first(:link, "Translate Me Game").click
    end

    scenario { expect(page.current_url).to eql(translate_me_url(lesson_one.number)) }
  end

  feature "Follow Game on Translate Me" do
    before do
      visit translate_me_path(lesson_one.number)
      click_link "Game"
    end

    scenario { expect(page.current_url).to eql(translate_me_url(lesson_one.number)) }
  end

  feature "Follow Lesson 1 on Translate Me" do
    before do
      visit translate_me_path(lesson_one.number)
      click_link "Lesson 1"
    end

    scenario { expect(page.current_url).to eql(lesson_url(lesson_one.number)) }
  end

  feature "Follow All Games on Translate Me" do
    before do
      visit translate_me_path(lesson_one.number)
      click_link "All Games"
    end

    scenario { expect(page.current_url).to eql(translate_me_all_url) }
  end
end