require 'spec_helper'

feature 'Viewing Lessons' do
  let!(:dictionary) { FactoryGirl.create(:dictionary) }
  let!(:lesson_one) { FactoryGirl.create(:lesson, number: 1) }
  let!(:lesson_two) { FactoryGirl.create(:lesson, number: 2) }

  before :each do
    @a = FactoryGirl.create(:letter, name: 'A', dictionary: dictionary)
    @b = FactoryGirl.create(:letter, name: 'B', dictionary: dictionary)

    noun = FactoryGirl.create(:part_of_speech, name: "noun", acronym: "N")
    adj  = FactoryGirl.create(:part_of_speech, name: "adjective", acronym: "ADJ")

    @first_word  = FactoryGirl.create(:entity, word: "bare", translation: "босые",
                                sentence: "He likes to walk around in his bare feet.",
                                letter: @b, lesson: lesson_two, part_of_speech: adj)
    @second_word = FactoryGirl.create(:entity, word: "ability", translation: "способность",
                                sentence: "His swimming abilities let him cross the entire lake.",
                                letter: @a, lesson: lesson_one, part_of_speech: noun)
  end

  scenario "All Lessons" do
    visit '/lessons/all'
    expect(page).to have_title("MerryEnglish")
    #FIXME: сделать header и footer отдельные тесты
    expect(page).to have_content("Dictionary")
    expect(page).to have_content("Lessons")
    expect(page).to have_content("Translate Me")

    expect(page).to have_content("Lessons")
    expect(page).to have_content("All Lessons")

    expect(page).to have_content("Lesson #{lesson_one.number}")
    expect(page).to have_content("<Translate Me Game>")
    expect(page).to have_content(@first_word.word)

    expect(page).to have_content("Lesson #{lesson_two.number}")
    expect(page).to have_content("<Translate Me Game>")
    expect(page).to have_content(@second_word.word)

    expect(page).to have_content("Lessons: #{lesson_one.number} #{lesson_two.number}")

    expect(page).to have_content("2015 by Alex Izotov (izotovalexander@gmail.com)")
  end
end