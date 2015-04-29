class RemoveDictionaryIdFromEntities < ActiveRecord::Migration
  def change
    remove_column :entities, :dictionary_id, :integer
  end
end
