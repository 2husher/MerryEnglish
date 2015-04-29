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

  feature "Translate Me All path" do
    before do
      visit translate_me_all_category_path(category)
    end

    scenario { should have_title("MerryEnglish") }
    #FIXME: сделать header и footer отдельные тесты
    scenario { should have_no_link 'All Words' }

    scenario { should have_link 'Words', href: dictionary_all_category_path(category) }
    scenario { should have_link 'Lessons' }
    scenario { should have_link 'Translate Me' }

    scenario { should have_css("div.container") }
    scenario { should have_css("h1") }

    scenario { should have_link("All Games") }

    scenario { should have_link("Lesson #{lesson_one.number}") }
    scenario { should have_link("Translate Me Game") }
    scenario { should have_content(first_word.word) }
    scenario { should have_content(third_word.word) }

    scenario { should have_link("Lesson #{lesson_two.number}") }
    scenario { should have_content(second_word.word) }

    scenario { should have_content("Games: #{lesson_one.number} #{lesson_two.number}") }
    scenario { should have_content("2015 by Alex Izotov (izotovalexander@gmail.com)") }

    feature "Follow Translate Me" do
      before do
        first(:link, "Translate Me Game").click
      end

      scenario { expect(page.current_url).to eql(translate_me_category_url(category, lesson_one.number)) }
    end

    feature "Follow Lesson 1" do
      before do
        click_link "Lesson 1"
      end

      scenario { expect(page.current_url).to eql(category_lesson_url(category, lesson_one)) }
    end
  end

  feature "Translate Me for Lesson 1 path" do
    before do
      visit translate_me_category_path(category, lesson_one.number)
    end

    scenario { should have_link("All Games") }
    scenario { should have_link("Next") }
    scenario { should have_no_link("Previous") }

    scenario { should have_content("Game for Lesson 1") }
    scenario { should have_content(first_word.word) }
    scenario { should have_content(third_word.word) }

    scenario { should have_content("Games: #{lesson_one.number} #{lesson_two.number}") }

    feature "Follow Game" do
      before do
        click_link "Game"
      end

      scenario { expect(page.current_url).to eql(translate_me_category_url(category, lesson_one.number)) }
    end

    feature "Follow Lesson 1" do
      before do
        click_link "Lesson 1"
      end

      scenario { expect(page.current_url).to eql(category_lesson_url(category, lesson_one)) }
    end

    feature "Follow All Games" do
      before do
        click_link "All Games"
      end

      scenario { expect(page.current_url).to eql(translate_me_all_category_url(category)) }
    end
  end
end