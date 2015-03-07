require 'spec_helper'

feature 'Viewing Categories' do
  subject { page }

  given!(:category) { FactoryGirl.create(:category) }

  feature "Root path" do
    before do
      visit root_path
    end

    scenario { should have_link 'First 600 Words' }
  end

  feature "Follow Categories" do
    before do
      visit root_path
      click_link "Categories"
    end

    scenario { expect(page.current_url).to eql(categories_url) }
  end

  feature "Follow All Words" do
    before do
      visit root_path
      click_link "All Words"
    end

    scenario { expect(page.current_url).to eql(dictionary_all_url) }
  end

  feature "Follow First 600 Words" do
    before do
      visit root_path
      click_link "First 600 Words"
    end

    scenario { expect(page.current_url).to eql(dictionary_all_category_url(category)) }
  end
end