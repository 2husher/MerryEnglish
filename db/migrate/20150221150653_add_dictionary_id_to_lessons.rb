class AddDictionaryIdToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :dictionary_id, :integer
  end
end
