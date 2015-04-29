require 'spec_helper'

feature 'Viewing All Words' do
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


  feature "All Words path" do
    before do
      visit dictionary_all_path
    end

    scenario { should have_link 'Categories' }
    scenario { should have_link 'All Words' }

    scenario { should have_no_link 'Words', href: dictionary_all_category_url(category) }
    scenario { should have_no_link 'Lessons' }
    scenario { should have_no_link 'Translate Me' }

    scenario { should have_content("Words #{first_word.word} - #{second_word.word}") }
    scenario { should have_link("All Letters") }
    scenario { should have_link("A", href: dictionary_path(a.name)) }
    scenario { should have_link("B", href: dictionary_path(b.name)) }
    scenario { should have_link("noun") }
    scenario { should have_link("adjective") }
  end

  feature "Letter A path" do
    before do
      visit dictionary_path(a.name)
    end

    scenario { should have_content("ability") }
    scenario { should have_content("способность") }
    scenario { should have_content("N") }
    scenario { should have_content("His swimming abilities let him cross the entire lake.") }
  end

  feature "Adjective path" do
    before do
      visit part_of_speech_path(adj.name)
    end

    scenario { should have_content("bare") }
    scenario { should have_content("босые") }
    scenario { should have_content("ADJ") }
    scenario { should have_content("He likes to walk around in his bare feet.") }
  end

  feature "Follow A" do
    before do
      visit dictionary_all_path
      click_link "A"
    end

    scenario { expect(page.current_url).to eql(dictionary_url(a.name)) }
  end

  feature "Follow noun" do
    before do
      visit dictionary_all_path
      click_link "noun"
    end

    scenario { expect(page.current_url).to eql(part_of_speech_url(noun.name)) }
  end

  feature "Follow All Letters" do
    before do
      visit dictionary_path(a.name)
      click_link "All Letters"
    end

    scenario { expect(page.current_url).to eql(dictionary_all_url) }
  end
end