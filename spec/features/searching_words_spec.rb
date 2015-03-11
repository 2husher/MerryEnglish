require 'spec_helper'

feature 'Searching Words' do
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
  given!(:third_word) { FactoryGirl.create(:entity, word: "barrier", translation: "барьер",
                                sentence: "The Great Wall was a barrier between China and its enemies.",
                                letter: b, lesson: lesson_one, part_of_speech: noun) }

  before do
    visit root_path
    fill_in 'Search for:', with: 'bar'
    click_button 'Search'
  end

  #scenario { expect(page.current_url).to eql(search_url(search: :bar, commit: "Search")) }
  scenario { expect(page.current_url).to eql("http://www.example.com/search?search=bar&commit=Search") }

  scenario { should have_content("bare") }
  scenario { should have_content("босые") }
  scenario { should have_content("ADJ") }
  scenario { should have_content("He likes to walk around in his bare feet.") }

  scenario { should have_content("barrier") }
  scenario { should have_content("барьер") }
  scenario { should have_content("N") }
  scenario { should have_content("The Great Wall was a barrier between China and its enemies.") }

  scenario { should_not have_content("ability") }
  scenario { should_not have_content("способность") }
  #scenario { should_not have_content("N") }
  scenario { should_not have_content("His swimming abilities let him cross the entire lake.") }
end