class RemoveIndexFromLessons < ActiveRecord::Migration
  def change
    remove_index :lessons, name: 'index_lessons_on_number'
  end
end
