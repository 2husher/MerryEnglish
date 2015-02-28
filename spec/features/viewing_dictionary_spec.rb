require 'spec_helper'

feature 'Viewing Dictionary' do
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

  before :each do
    ('C'..'Z').each do |l|
      FactoryGirl.create(:letter, name: l, dictionary: dictionary)
    end

    pos_hash = { "verb" => "V", "adverb" => "ADV", "conjunction" => "CONJ", "preposition" => "PREP"}
    pos_hash.each do |n, acr|
      FactoryGirl.create(:part_of_speech, name: n, acronym: acr)
    end
  end

  scenario "Dictionary all path" do
    visit dictionary_all_path

    expect(page).to have_title("MerryEnglish")

    expect(page).to have_content("Dictionary")
    expect(page).to have_content("Lessons")
    expect(page).to have_content("Translate Me")

    expect(page).to have_content("Dictionary")
    expect(page).to have_content("All Letters A B C D E F G H I J K L M N O P Q R S T U V W X Y Z ")
    expect(page).to have_content("noun | adjective | verb | adverb | conjunction | preposition |")
    expect(page).to have_content("Index")

    #FIXME: порядок следования слов по алфавиту
    expect(page).to have_content("bare")
    expect(page).to have_content("босые")
    expect(page).to have_content("ADJ")
    expect(page).to have_content("He likes to walk around in his bare feet.")

    expect(page).to have_content("ability")
    expect(page).to have_content("способность")
    expect(page).to have_content("N")
    expect(page).to have_content("His swimming abilities let him cross the entire lake.")

    expect(page).to have_content("2015 by Alex Izotov (izotovalexander@gmail.com)")
  end

  scenario "Dictionary path" do
    visit dictionary_path(a.name)

    expect(page).not_to have_content("bare")
    expect(page).not_to have_content("босые")
    expect(page).not_to have_content("ADJ")
    expect(page).not_to have_content("He likes to walk around in his bare feet.")

    expect(page).to have_content("ability")
    expect(page).to have_content("способность")
    expect(page).to have_content("N")
    expect(page).to have_content("His swimming abilities let him cross the entire lake.")
  end

  scenario "Part of speech path" do
    visit part_of_speech_path(noun.name)

    expect(page).not_to have_content("bare")
    expect(page).not_to have_content("босые")
    expect(page).not_to have_content("ADJ")
    expect(page).not_to have_content("He likes to walk around in his bare feet.")

    expect(page).to have_content("ability")
    expect(page).to have_content("способность")
    expect(page).to have_content("N")
    expect(page).to have_content("His swimming abilities let him cross the entire lake.")
  end

  scenario "Follow A" do
    visit dictionary_all_path

    click_link "A"
    expect(page.current_url).to eql(dictionary_url(a.name))
  end

  scenario "Follow noun" do
    visit dictionary_all_path
    #FIXME: N for noun and N for N link

    click_link "noun"
  end

  scenario "Follow All Letters" do
    visit dictionary_path(a.name)

    click_link "All Letters"
    expect(page.current_url).to eql(dictionary_all_url)
  end
end