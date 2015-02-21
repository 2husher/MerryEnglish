class AddLetterIdToEntity < ActiveRecord::Migration
  def change
    add_column :entities, :letter_id, :integer
  end
end
