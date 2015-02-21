class AddDictionaryIdToLetters < ActiveRecord::Migration
  def change
    add_column :letters, :dictionary_id, :integer
  end
end
