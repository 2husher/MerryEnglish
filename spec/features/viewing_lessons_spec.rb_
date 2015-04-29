require 'spec_helper'

feature 'Viewing Lessons' do
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


  feature "All Lessons path" do
    before do
      visit lessons_all_path
    end

    scenario { should have_title("MerryEnglish") }
    #FIXME: сделать header и footer отдельные тесты
    scenario { should have_content("Dictionary") }
    scenario { should have_content("Lessons") }
    scenario { should have_content("Translate Me") }

    scenario { should have_content("Lessons") }
    scenario { should have_content("All Lessons") }

    scenario { should have_link("Lesson #{lesson_one.number}") }
    scenario { should have_content("<Translate Me Game>") }
    scenario { should have_content(first_word.word) }

    scenario { should have_link("Lesson #{lesson_two.number}") }
    scenario { should have_content(second_word.word) }

    scenario { should have_content("Lessons: #{lesson_one.number} #{lesson_two.number}") }

    scenario { should have_content("2015 by Alex Izotov (izotovalexander@gmail.com)") }
  end

  feature "Lesson 1 path" do
    before do
      visit lesson_path(lesson_one.number)
    end

    scenario { should have_content("Lesson #{lesson_one.number}") }
    scenario { should have_content("<Translate Me Game>") }

    scenario { should have_content(second_word.word) }
    scenario { should have_content(second_word.translation) }
    scenario { should have_content(second_word.sentence) }
    scenario { should have_content(second_word.part_of_speech.acronym) }

    scenario { should have_content("Lessons: #{lesson_one.number} #{lesson_two.number}") }
  end

  feature "Follow Lesson 1" do
    before do
      visit lessons_all_path
      click_link "Lesson #{lesson_one.number}"
    end

    scenario { expect(page.current_url).to eql(lesson_url(lesson_one.number)) }
  end

  feature "Follow Translate Me Game" do
    before do
      visit lessons_all_path
      first(:link, "Translate Me Game").click
    end

    scenario { expect(page.current_url).to eql(translate_me_url(lesson_one.number)) }
  end

  feature "Follow Translate Me Game on Lesson 1" do
    before do
      visit lesson_path(lesson_one.number)
      click_link "Translate Me Game"
    end

    scenario { expect(page.current_url).to eql(translate_me_url(lesson_one.number)) }
  end

  feature "Follow All Lessons" do
    before do
      visit lesson_path(lesson_one.number)
      click_link "All Lessons"
    end

    scenario { expect(page.current_url).to eql(lessons_all_url) }
  end
end