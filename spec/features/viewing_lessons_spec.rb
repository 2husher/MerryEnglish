require 'spec_helper'

feature 'Viewing Lessons' do

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


  scenario "All Lessons path" do
    visit lessons_all_path

    expect(page).to have_title("MerryEnglish")
    #FIXME: сделать header и footer отдельные тесты
    expect(page).to have_content("Dictionary")
    expect(page).to have_content("Lessons")
    expect(page).to have_content("Translate Me")

    expect(page).to have_content("Lessons")
    expect(page).to have_content("All Lessons")

    expect(page).to have_link("Lesson #{lesson_one.number}")
    expect(page).to have_content("<Translate Me Game>")
    expect(page).to have_content(first_word.word)

    expect(page).to have_link("Lesson #{lesson_two.number}")
    expect(page).to have_content(second_word.word)

    expect(page).to have_content("Lessons: #{lesson_one.number} #{lesson_two.number}")

    expect(page).to have_content("2015 by Alex Izotov (izotovalexander@gmail.com)")
  end

  scenario "Lesson 1 path" do
    visit lesson_path(lesson_one.number)

    expect(page).to have_content("Lesson #{lesson_one.number}")
    expect(page).to have_content("<Translate Me Game>")

    expect(page).to have_content(second_word.word)
    expect(page).to have_content(second_word.translation)
    expect(page).to have_content(second_word.sentence)
    expect(page).to have_content(second_word.part_of_speech.acronym)

    expect(page).to have_content("Lessons: #{lesson_one.number} #{lesson_two.number}")
  end

  scenario "Follow Lesson 1" do
    visit lessons_all_path

    click_link "Lesson #{lesson_one.number}"
    expect(page.current_url).to eql(lesson_url(lesson_one.number))
  end

  scenario "Follow Translate Me Game" do
    visit lessons_all_path

    first(:link, "Translate Me Game").click
    expect(page.current_url).to eql(translate_me_url(lesson_one.number))
  end

  scenario "Follow Translate Me Game on Lesson 1" do
    visit lesson_path(lesson_one.number)

    click_link "Translate Me Game"
    expect(page.current_url).to eql(translate_me_url(lesson_one.number))
  end

  scenario "Follow All Lessons" do
    visit lesson_path(lesson_one.number)

    click_link "All Lessons"
    expect(page.current_url).to eql(lessons_all_url)
  end
end