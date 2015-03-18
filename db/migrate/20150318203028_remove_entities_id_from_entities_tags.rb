class RemoveEntitiesIdFromEntitiesTags < ActiveRecord::Migration
  def change
    remove_column :entities_tags, :entities_id, :integer
  end
end
