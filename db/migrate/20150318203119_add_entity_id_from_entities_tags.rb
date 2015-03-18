class AddEntityIdFromEntitiesTags < ActiveRecord::Migration
  def change
    add_column :entities_tags, :entity_id, :integer
  end
end
