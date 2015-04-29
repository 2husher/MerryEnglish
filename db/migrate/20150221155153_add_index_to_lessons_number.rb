class AddIndexToLessonsNumber < ActiveRecord::Migration
  def change
    add_index :lessons, :number
  end
end
