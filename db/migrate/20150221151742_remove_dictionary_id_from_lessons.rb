class RemoveDictionaryIdFromLessons < ActiveRecord::Migration
  def change
    remove_column :lessons, :dictionary_id, :integer
  end
end
