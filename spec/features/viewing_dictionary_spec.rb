require 'spec_helper'

feature 'Viewing Dictionary' do
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


  feature "Dictionary all path" do
    before do
      visit dictionary_all_path
    end

    scenario { should have_title("MerryEnglish") }

    scenario { should have_content("Dictionary") }
    scenario { should have_content("Lessons") }
    scenario { should have_content("Translate Me") }

    scenario { should have_content("Dictionary") }
    scenario { should have_content("All Letters A B") }
    scenario { should have_content("noun | adjective") }
    scenario { should have_content("Index") }

    #FIXME: порядок следования слов по алфавиту
    scenario { should have_content("bare") }
    scenario { should have_content("босые") }
    scenario { should have_content("ADJ") }
    scenario { should have_content("He likes to walk around in his bare feet.") }

    scenario { should have_content("ability") }
    scenario { should have_content("способность") }
    scenario { should have_content("N") }
    scenario { should have_content("His swimming abilities let him cross the entire lake.") }

    scenario { should have_content("2015 by Alex Izotov (izotovalexander@gmail.com)") }
  end

  feature "Dictionary path" do
    before do
      visit dictionary_path(a.name)
    end

    scenario { should_not have_content("bare") }
    scenario { should_not have_content("босые") }
    scenario { should_not have_content("ADJ") }
    scenario { should_not have_content("He likes to walk around in his bare feet.") }

    scenario { should have_content("ability") }
    scenario { should have_content("способность") }
    scenario { should have_content("N") }
    scenario { should have_content("His swimming abilities let him cross the entire lake.") }
  end

  feature "Part of speech path" do
    before do
      visit part_of_speech_path(noun.name)
    end

    scenario { should_not have_content("bare") }
    scenario { should_not have_content("босые") }
    scenario { should_not have_content("ADJ") }
    scenario { should_not have_content("He likes to walk around in his bare feet.") }

    scenario { should have_content("ability") }
    scenario { should have_content("способность") }
    scenario { should have_content("N") }
    scenario { should have_content("His swimming abilities let him cross the entire lake.") }
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
    #FIXME: N for noun and N for N link

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