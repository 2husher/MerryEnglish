require 'spec_helper'

feature 'Viewing Lessons' do
  subject { page }

  given!(:category) { FactoryGirl.create(:category) }

  given!(:lesson_one) { FactoryGirl.create(:lesson, category: category) }
  given!(:lesson_two) { FactoryGirl.create(:lesson, number: 2, category: category) }

  given!(:a) { FactoryGirl.create(:letter) }
  given!(:b) { FactoryGirl.create(:letter, name: 'B') }

  given!(:noun) { FactoryGirl.create(:part_of_speech) }
  given!(:adj) { FactoryGirl.create(:part_of_speech, name: "adjective", acronym: "ADJ") }

  given!(:first_word) { FactoryGirl.create(:entity, letter: a, lesson: lesson_one, part_of_speech: noun) }
  given!(:second_word) { FactoryGirl.create(:entity, word: "bare", translation: "босые",
                                sentence: "He likes to walk around in his bare feet.",
                                letter: b, lesson: lesson_two, part_of_speech: adj) }
  given!(:third_word) { FactoryGirl.create(:entity, word: "aim", translation: "цель",
                                sentence: "My aim is to become a helicopter pilot.",
                                letter: a, lesson: lesson_one, part_of_speech: noun) }

  feature "All Lessons path" do
    before do
      visit lessons_all_category_path(category)
    end

    scenario { should have_title("MerryEnglish") }
    #FIXME: сделать header и footer отдельные тесты
    scenario { should have_no_link 'All Words' }

    scenario { should have_link 'Words', href: dictionary_all_category_path(category) }
    scenario { should have_link 'Lessons' }
    scenario { should have_link 'Translate Me' }

    scenario { should have_content("Lessons") }
    scenario { should have_link("All Lessons") }

    scenario { should have_link("Lesson #{lesson_one.number}") }
    scenario { should have_link("Translate Me Game") }
    scenario { should have_content(first_word.word) }
    scenario { should have_content(third_word.word) }

    scenario { should have_link("Lesson #{lesson_two.number}") }
    scenario { should have_content(second_word.word) }

    scenario { should have_content("Lessons: #{lesson_one.number} #{lesson_two.number}") }

    scenario { should have_content("2015 by Alex Izotov (izotovalexander@gmail.com)") }
  end

  feature "Lesson 1 path" do
    before do
      visit lesson_category_path(category, lesson_one.number)
    end

    scenario { should have_content("Lesson #{lesson_one.number}") }
    scenario { should have_link("Translate Me Game") }

    scenario { should have_link("All Lessons") }
    scenario { should have_link("Next") }
    scenario { should have_no_link("Previous") }

    scenario { should have_content(first_word.word) }
    scenario { should have_content(first_word.translation) }
    scenario { should have_content(first_word.sentence) }
    scenario { should have_content(first_word.part_of_speech.acronym) }

    scenario { should have_content("Lessons: #{lesson_one.number} #{lesson_two.number}") }
  end

  feature "Follow Lesson 1" do
    before do
      visit lessons_all_category_path(category)
      click_link "Lesson #{lesson_one.number}"
    end

    scenario { expect(page.current_url).to eql(lesson_category_url(category, lesson_one.number)) }
  end

  feature "Follow Translate Me Game" do
    before do
      visit lessons_all_category_path(category)
      first(:link, "Translate Me Game").click
    end

    scenario { expect(page.current_url).to eql(translate_me_category_url(category, lesson_one.number)) }
  end

  feature "Follow Translate Me Game on Lesson 1" do
    before do
      visit lesson_category_path(category, lesson_one.number)
      click_link "Translate Me Game"
    end

    scenario { expect(page.current_url).to eql(translate_me_category_url(category, lesson_one.number)) }
  end
end